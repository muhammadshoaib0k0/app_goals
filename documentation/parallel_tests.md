# How to employ and run your tests with parallel_tests to speed up test execution

## Introduction

When your tests grow massively over time, the test execution can take a lot of time.
One easy way to speed up your test execution is to use the parallel_tests gem: https://github.com/grosser/parallel_tests.
It comes along with some useful rake tasks that let you setup your local test environment shortly to run your specs or unit-tests in parallel.

1. Add the parallel_tests gem to your Gemfile test sections like that:

```ruby
# ./Gemfile

group :development, :test do
  gem 'parallel_tests'
end
```

2. Change your database.yml file. The parallel_tests gem uses the test database for spec, features, ... Notice the <%= ENV['TEST_ENV_NUMBER'] %> appended to the database name in the test section.

```ruby
# ./config/database.yml

...

test:
  <<: *default
  database: my_database_name_test<%= ENV['TEST_ENV_NUMBER'] %>
```

3. Create your test databases (as many databases as your PC has CPU cores)

```ruby
rake parallel:create
```

4. Prepare your test databases with the db schema. Don't forget to run your migrations (on the test db) before you execute this command.

```ruby
rake parallel:prepare
```

5. Now you are ready to rumble. You can use these commands to run your features, specs or unit tests:

```ruby
rake parallel:test RAILS_ENV=test            # Test::Unit
rake parallel:spec RAILS_ENV=test            # RSpec

rake parallel:features[2] RAILS_ENV=test     # example how to execute cucumber features with (only) 2 cores
rake 'parallel:features[2]' RAILS_ENV=test   # in case your zsh terminal can't process the [] argument
```

6. When you need to perform some cleanup tasks at the end you might want to need run this only once.

Basic usage: `ParallelTests.wait_for_other_processes_to_finish`

Advanced:

```ruby
# copied from from https://github.com/grosser/parallel_tests#running-things-once

require 'parallel_tests'

# preparation task:
# affected by race-condition: first process may boot slower than the second
# either sleep a bit or use a lock for example File.lock
ParallelTests.first_process? ? prepare_something : sleep(1)

# cleanup task:
# last_process? does NOT mean last finished process, just last started
ParallelTests.last_process? ? cleanup_something : sleep(1)

at_exit do
  if ParallelTests.first_process?
    ParallelTests.wait_for_other_processes_to_finish
    undo_something
  end
end
```
## Integrate parallel_specs into gitlab-ci

It is quite easy to integrate parallel_tests with the ci if you only want to use a single gitlab runner with several cores.

1. If your project has a dedicated pipeline database config, change that accordingly

```yaml
# database.yml.gitlab

test:
  ...
  database: taxcollect-test<%= ENV['TEST_ENV_NUMBER'] %>
```

2. Now you need to configure the rspec job

```yaml
# .gitlab-ci.yml

rspec:
  ...
  script:
    - cp config/database.yml.gitlab config/database.yml
    - bundle exec rake parallel:setup                    # instead of rake db:create db:schema:load
    - bundle exec rake parallel:spec RAILS_ENV=test      # instead of bundle exec rspec
  coverage: '/\(\d+.\d+\%\) covered/'
  tags:
    - multicore                                          # this will attach this job to multicore runner

```

## Configure RspecJunitFormatter

In case your project is reporting test results in junit format, parallel_specs need some further adjustments.

1. We want to write junit reports per process. We can configure default flags for the `parallel:spec`command by adding this file to the projects directory.

```yaml
# .rspec_parallel

--format progress
--format RspecJunitFormatter
--out <%= ENV['CI_PROJECT_DIR'] %>/rspec<%= ENV['TEST_ENV_NUMBER'] %>.xml
```

2. Change the artifacts collector to consider all junit reports

```yaml
# .gitlab-ci.yml

rspec:
  ...
  artifacts:
    when: always
    expire_in: 2 days
    paths:
      - rspec*.xml
    reports:
      junit:
        - rspec*.xml
```

### Multirunner setup
However if you want to use multiple gitlab runners in parallel you need to do some adjustments:

1. Add `TEST_ENV_NUMBER` to `DATABASE_URL` by adding following line to your test environment.

```ruby
# ./config/environments/test.yml

...

ENV["DATABASE_URL"] += ENV["TEST_ENV_NUMBER"] if ENV["TEST_ENV_NUMBER"] && ENV["DATABASE_URL"]
```

2. Add the following script to your `bin` and call it on the spec stage of your gitlab ci and make it executable (`chmod +x bin/parallel_tests.sh`)

```bash
#!/bin/sh

set -x

# CI_NODE_INDEX is a GitLab variable
# telling you at what CI_NODE you are currently running
# when you are using https://docs.gitlab.com/ee/ci/yaml/#parallel
INDEX="${CI_NODE_INDEX:-}"
# CI_NODE_TOTAL is always set by GitLab-CI-runner
# if you have not configured 'parallel' CI_NODE_TOTAL=1
# otherwise total will be either CPU cores or 1 if not parallelized
TOTAL="${CI_NODE_TOTAL:-1}"
# how many parallel_steps should run per CI_NODE-host
steps="${PARALLEL_STEPS:-2}"
# the index, corrected to count at 0 instead of 1
index="$((${INDEX}-1))"

# with steps we allow groups to run
START="$(($steps * $index + 1))"
STOP="$(($steps * $index + $steps))"

# generate a list of which range of groups should be run
# generates something like "1,2" for the first two groups, "3,4"
groups="$(seq -s, "${START}" 1 "${STOP}")"
# the total amount of job we are running
TOTAL_JOBS="$(( ${TOTAL} * ${steps} ))"

RAILS_ENV=test bundle exec rake parallel:create["${steps}"]
RAILS_ENV=test bundle exec rake parallel:migrate["${steps}"]
RAILS_ENV=test bundle config disable_exec_load true

RAILS_ENV=test bundle exec parallel_rspec -n "${TOTAL_JOBS}" --only-group "${groups}" ./spec

mkdir $CI_PROJECT_DIR/coverage
cp -r $(pwd)/coverage/.resultset.json $CI_PROJECT_DIR/coverage/.resultset-$CI_NODE_INDEX.json
ls -la $CI_PROJECT_DIR/coverage
```

3. Adjust test stage on `gitlab-ci.yml` so that it uses the `.bin/parallel_tests.sh` script

```yml
rspec:
  extends: .services
  stage: test
  image: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  script: ./bin/parallel_tests.sh
  parallel: 2
  artifacts:
    expire_in: 1 day
    paths:
      - coverage/
  except:
    - schedules
```

4. Add new stage to the `gitlab-ci.yml` which collates the coverage results.

```yml
report_coverage:
  stage: report_coverage
  image: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  dependencies:
    - rspec # stage before coverage_report
  before_script:
    - ls $CI_PROJECT_DIR/coverage/.?*
    - cd /usr/src/app # working directory inside docker image
  script: bundle exec bin/coverage_report
  coverage: '/\(\d+.\d+\%\)\scovered/'
```

5. Add a script for the collation of coverage reports to your `bin` folder and make it executable (`chmod +x bin/coverage_report`)

```ruby
#!/usr/bin/env ruby

require "simplecov"

SimpleCov.collate Dir["#{ENV['CI_PROJECT_DIR']}/coverage/.resultset-*.json"]
```

You can also check the implementation on the `gym10_members` project.

6. To your test stage add the parallel attribute (defines how many runners to use)

```yml
parallel: 2 # will use 2 runners with 2 cores each = 4 cores
```
