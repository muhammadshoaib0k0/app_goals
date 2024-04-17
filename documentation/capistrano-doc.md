# How to: Capistrano

This is a documentation about capistrano tailored for the usage in our company. For a more in depth guide, extended functionality and available plugins use the [official capistrano wiki](https://github.com/capistrano/capistrano/blob/master/README.md).

## Installation 
### Recommendations
- Before you install the Capistrano gem it is recommended to set up [dotenv-rails](https://github.com/bkeepers/dotenv) to avoid leaking secrets into the repo and also to have a single point of truth to be able to provide and easily maintain environment variables (for example sentry-credentials, database-configuration, rails-specific vars, and so on). Please care not to combine it with the usage of the [config-gem](https://github.com/rubyconfig/config) as this will most certainly cause multiple issues.
**If some credentials were already pushed into the repository use the [BFG](https://rtyley.github.io/bfg-repo-cleaner/) to clean it out of the History just to be save.**
***(before doing something so drastic you should ask the #devops team)***

- It's beneficial to create the ansible part of the capistrano deploy, the provisioning, beforehand to have an overview about the necessary files and be able to test the your setup right after creating it. It will also provide you with a list of files and directories to link in your deploy script later. There are nice documentations about it for the [staging-servers](devops/staging-server-documentation.md) and the usage of the [ansible repository](https://gitlab.conlance.org/devOps/ansible-2021/-/blob/master/Readme.md) itself.

### Setting up the gem

**First you have to Install the gem in your project.**
If you dont know how to do this this [Guide](https://capistranorb.com/documentation/getting-started/installation/) might be helpful.
In most of the cases for a basic rails application we add the following gems to our Gemfile:

```ruby
group :development, :test do
  gem "capistrano"
  gem "capistrano3-puma"
  gem "capistrano-rails"
  gem "capistrano-rbenv"
end
```

## Configuration

**Capistrano has to be configured for your project to work**
The default conlance capistrano files for configuration can be found in the devops/capistrano directory here in the documentation but please don't just copy/paste it because this will not work!

Let's have a quick look at the different files. If you need further explanation please feel free to ask @Lukas, @Sascha, @Klaus or in emergency cases @Florian.

### **Capfile**
The [Capfile](devops/capistrano/Capfile) is used to tell capistrano which plugins we want to use and to load custom tasks we defined to orchestrate the deploy. That's pretty straight forward and instead of further explaining the contents here are some examples of useful additional plugins:
- "capistrano/sidekiq" sidekiq integration for capistrano
- "whenever/capistrano" to add your whenever tasks to the crontab
- "capistrano/faster_assets" if your application takes a long time to compile assets this can speed up deployment immense
- "capistrano/delayed_job" to manage your delayed_job configuration

**Don't forget to check the documentation of the plugin you want to use as most of these also have to be added to your Gemfile for example.**

### **deploy.rb**

The [deploy.rb](devops/capistrano/deploy.rb) is the heart of your deploy and defines almost all the important stuff. Just put the file into your project in the config directory and remove the dummy values and the comments from it. Other good examples for a deploy.rb can be found in the projects das_workout or quality_order_management. It is always a good choice to look at the official [documentation](https://capistranorb.com/documentation/getting-started/installation/) for a deeper insight on the possibilities.

### **staging.rb (environment specific deploy files)**

As you can't use the same configurations for all environments you need additional environment specific files for your deployment that overwrite the configurations set in the deploy.rb. This includes for example user, branch or server urls. Have a look at the example [staging.rb](devops/capistrano/staging.rb). If you experience issues with the rbenv_root or rbenv_prefix also overwrite them in this file again without using any fetch(:variable) for which the variable is set in deploy.rb.

### **service.rake**

This is a custom file you won't find much about in the documentation of capistrano. We use it to manage which services should always be restarted on crash or also need a restart after deployment. For a basic rails application without redis or other advanced services you can just copy the content of [service.rake](devops/capistrano/service.rake). If you want to add a new service you can just add a line similar to lines 10 and 45 in the example. In line 10 you define the systemctl command that will execute your userunit. Similar to line 45 you define the service specific command that is necessary for your service to run. You can find a good example for delayed_job in the project quality_order_management.

### **check.rb**

The [check.rb](devops/capistrano/recipes/check.rb) is a recipe that checks if you're on the correct branch when you're running ```be cap <environment> deploy``` and if there are uncommited changes compared to the branch on gitlab. The ```check.rb``` file should be placed here: ```config/recipes/check.rb``` You can find a example for this in the "Kundenpflege Backend" project.

## Examples

- [das_workout/truoutdoor](https://gitlab.conlance.org/das-workout/das_workout_backend)
- [quality_order_management](https://gitlab.conlance.org/butsch/quality_order_management)

advanced capistrano only managed but not created by conlance
- [mybilio](https://gitlab.conlance.org/mybilio/mybilio-server)

## After Set-up
When you have finished creating your config files and set up everything you can deploy
but before you do that its probably a good test to see if everything works properly
you can run a test/dry-run with
```sh
$ bundle exec cap staging deploy --dry-run
```
if that runs you can deploy for that just re-run the command but without the flag `--dry-run` 
 
```sh
$ bundle exec cap staging deploy
```
Important: Don't forget to activate [ssh-forwarding](https://www.cloudsavvyit.com/25/what-is-ssh-agent-forwarding-and-how-do-you-use-it/)!
```sh
$ ssh-agent && ssh-add ~/.ssh/.id_rsa
```
or capistrano won't be able to access the server!


## CI deployment
These steps are necessary to add automatic deployment to the gitlab pipeline:

1. Add the deployment job to the gitlab-ci configuration (please adapt to your needs):
    ```yaml
        deploy_staging:
          stage: deploy
          image: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
          before_script:
            - which ssh-agent || (apk add openssh openssh-client)
            - cd /usr/src/app
            - source bin/ci_ssh_setup.sh
            - git config --global user.name "botty" # set name for revision log
          script: bundle exec cap staging deploy
          only: 
            - staging
    ```
2. Add the ssh script (bin/ci_ssh_setup.ssh):
   ```bash
      #!/bin/sh
      set -e

      mkdir -p ~/.ssh
      echo $SSH_PRIVATE_KEY | base64 -d > ~/.ssh/id_rsa
      chmod 600 ~/.ssh/id_rsa
      ssh-keygen -f ~/.ssh/id_rsa -y > ~/.ssh/id_rsa.pub
      chmod 600 ~/.ssh/id_rsa.pub
      eval "$(ssh-agent)"
      ssh-add ~/.ssh/id_rsa
   ```
3. Set the `SSH_PRIVATE_KEY` CI variable in the gitlab project  
   Ask @lukas for it. The key has to be added as a base64 string.

4. Make sure the target server has the Bot user in the authorized keys  
  We use that user for capistrano CI deployments: https://gitlab.conlance.org/botty, this user has an SSH key which has to be added to the target server. This should be done by default for all application servers.
  Ask @lukas or @sascha when you're unsure.

5. Set the deployment user name (for the revision log) - optional  
  If you want to set the deployment user name ("botty") you can add `set :local_user, -> { `git config user.name`.chomp }` to your deploy.rb.
