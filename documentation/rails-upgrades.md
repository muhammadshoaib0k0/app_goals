# Pre-requisites of Rails
As Rails is being actively developed and maintained we are blessed with new releases quite frequently. There are multiple reasons to upgrade existing apps (security, new features, speed improvements, etc.) so it's a quite common task for us.

Some helpful links:

- [offical Ruby page](https://www.ruby-lang.org/en/) (if you need or want to upgrade Ruby beforehand)
- [Ruby on Rails official release page](https://rubyonrails.org/category/releases)
- [Overview of security support for Rails versions](https://endoflife.date/rails)
- [The official upgrade docs](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html) (they are very detailed, mostly you'd use them to look up specific things and not as a step by step guide)

## Helpful steps
⚠️ Please **don't** consider this as a complete checklist but a summary of helpful tasks

- read the Rails changelog (checkout the Rails release page link above) to get an overview of the changes and requirements and what to expect during the upgrade
- raise Ruby version (check the requirements of your target Rails version)
- raise Rails version
- run `rails app:update`
- now use the version control tool of your choice to compare the changes
  -> apply the new defaults if possible, check the docs when in doubt
  -> you can use https://railsdiff.org to check the differences between two Rails versions
- check all rails default files/values first (bin/setup, etc.)
- if necessary: update gems (for example if they are not compatible with your new Rails version or bundle audit complains. In general it's better to do not mandatory updates afterwards so you can better spot possible bugs)
- run the test suite
- fix tests if necessary
- set new framework defaults (https://guides.rubyonrails.org/configuring.html#versioned-default-values) and solve each line using web search to find the correct choice for the application
- run your test suite again
- fix specs again if necessary
- do some smoke testing (you want to spend more time here if it's a major upgrade) locally and on staging
- especially try out the parts which are not covered by test

For further maintenance update all of your gems and node dependencies after your app has been running on production with the new Rails version without problems for some time (you could and should also do this from time to time without a preceding Rails upgrade by the way 🙂)
