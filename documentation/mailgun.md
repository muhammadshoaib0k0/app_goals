# Mailgun

Mailgun is a mail delivery service we use for the majority of our projects. For further information visit: https://www.mailgun.com

## Setup
  The API setup is recommended because it's faster and more flexible, the SMTP setup should only be used in older projects, where the API setup is not possible.

  - ask @florian which domain to use for your project (currently supported: conlance.de, conlance.org, mandacom.de, additional    domains need access to the DNS Records); we can send mails from the top-level domains as well as all subdomains; subdomains should look like this: mail.`DOMAIN`.`TLD`; more information about how to select a proper domain -> [here](development-issues/mails.md)
  - the ENV vars have to be added to the server, so please notify the members of the devops team in the Teams channel "DevOps Inbox" to add them (we mostly use [dotenv](https://github.com/bkeepers/dotenv) to load them when starting the app)
  
## API setup with Rails

  - add the `mailgun-ruby` gem: https://github.com/mailgun/mailgun-ruby 
  - ask any of the Mailgun admins to create a new `API_KEY` for the domain you are using
  - set the mailer config in the respective environment .rb (e.g. staging.rb) like this:
    ```ruby
    config.action_mailer.delivery_method = :mailgun
    config.action_mailer.mailgun_settings = {
      api_key: ENV.fetch('MAILGUN_API_KEY'),
      domain: ENV.fetch('MAILGUN_DOMAIN'),
      api_host: 'api.eu.mailgun.net'
    } 
    ```
  - set the ENV vars for `MAILGUN_API_KEY` and `MAILGUN_DOMAIN`  

## SMTP setup with Rails

- ask any of the Mailgun admins (currently @florian, @sascha and @lukas) to create a new SMTP user within this domain (or use an existing one), the SMTP credentials then can be added to the ENV vars by a member of the devops team
- you can also ask some of the admins for an invitation for Mailgun so that you can access the Dashboard and other stuff
- change your environment configs (probably staging and production):
  - set the smtp-host (`SMTP_ADDRESS`): `smtp.eu.mailgun.org` in the ENV vars
  - set the domain (`SMTP_DOMAIN`) in the ENV vars; it would be `mg.mandacom.de` for mandacom for example
  - add the user_name and password in the ENV vars
- use this as a reference setup:

    ```ruby
    config.action_mailer.smtp_settings = {
        address: ENV.fetch('SMTP_ADDRESS'),
        port: 25,
        domain: ENV.fetch('SMTP_DOMAIN'),
        authentication: :login,
        enable_starttls_auto: true,
        user_name: ENV.fetch('SMTP_USER'),
        password: ENV.fetch('SMTP_PASSWORD')
    }
    ```

## Sidenotes
   - for staging: add the `recipient_interceptor` gem like this: https://gitlab.conlance.org/conlance/documentation/-/blob/master/development-issues/mails.md
   - to avoid notations like: "info=example.cnlc@mail.cnlc.de <info=example.cnlc@mail.cnlc.de>; On behalf of; cnlc.de <info@ecnlc.de>" you should keep this in mind: https://help.mailgun.com/hc/en-us/articles/360012491394-Why-Do-I-See-On-Behalf-Of-in-My-Email-
   
:tada: You are good to go! Now you can test your setup and deliver some mails 📨
