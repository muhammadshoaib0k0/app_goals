# Configuration values (in Rails)

## general guideline

1. prefer the [dotenv](https://github.com/bkeepers/dotenv) over the [config](https://github.com/rubyconfig/config) gem
    > there are no tough advantages/disadvantes for one of the two but we should stick to one so that it'll be easier to grasp the configurations of a project
2. don't use `.env` as it will be added through Ansible and used for deployments
3. add a `.env.template` in the repository (same as .env but with dummy values)
4. add a `.env.test` for the test environment
5. use a `.env.development` for configuration you need in the dev environment
6. if you need specific configurations locally create a `.env.development.local` (it'll override `.env.development`)

Note:  
If you have nested configuration values it might make sense to use a YAML file (in the config folder for example) and load it with `YAML.load_file` (please only do it once for example with a constant). Another option would be to prefix the environment variables.

## ENV vs ENV.fetch
Always use **ENV.fetch** instead of just **ENV** to make sure your application doesn't even start when the concerning variable is not set. Otherwise it will take you a long time to figure out why your application crashes when it comes to environment variables.

### examples
  
standard:  
`ENV.fetch('FOOBAR')`

with default value as fallback:  
`ENV.fetch('FOOBAR', 'default_value_here')`

with an exception notification via SENTRY as default (depending on the installed sentry-ruby/sentry-raven version use Raven. or Sentry.):  
`ENV.fetch('FOOBAR', Raven.capture_message("You forgot to set the ENV variable FOOBAR!"))`
