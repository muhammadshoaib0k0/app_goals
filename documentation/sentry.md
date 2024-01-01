# Sentry
This section contains information about setting up Sentry in our projects. Feel free to extend it.

## Setup for Javascript in Rails (with webpack)
Resources:
  - [Official documentation](https://docs.sentry.io/platforms/javascript/)

We're using the recommended package `@sentry/browser`.
Follow these steps to catch JS errors in Sentry:
1. Add the packages to your dependencies: `yarn add @sentry/browser @sentry/tracing`
2. Add sentry to your packs: create a new file like `sentry.js` in `app/webpacker/packs` with this content:
    ```javascript
    import * as Sentry from '@sentry/browser'
    import { Integrations } from '@sentry/tracing'

    Sentry.init({
    dsn: 'https://70962e8d8bac4ecf91e4032b58318676@sentry.conlance.org/43', // you get this in the Sentry settings of your projects (-> Client Keys)
    release: process.env.REVISION // this will be passed during the docker build, see below
    integrations: [new Integrations.BrowserTracing()]
    })

    window.Sentry = Sentry
    ```
3. Add this pack to your layout in the head with: `= javascript_pack_tag 'sentry' if !Rails.env.development?` (add it before all other JS)
4. To set more context, add a template, which will be rendered in your application layout. Checkout the documentation and adjust it to your needs:
   ```slim
    javascript:
        Sentry.configureScope(scope => {
            scope.setTag("environment", "#{Rails.env}"); // we set this to differ between staging and production
            scope.setUser(id: "#{current_user&.id")
        });
    ```
5. Upload source maps in gitlab CI:
    - In your Dockerfile:
        Make the Revision accessible (before the asset compilation!):
        ```yaml
        ARG REVISION=dev
        ENV REVISION $REVISION
        RUN echo "$REVISION" > REVISION
        ```
    - Add this to your webpack environment:
        ```js
        new webpack.DefinePlugin({
            'process.env.REVISION': JSON.stringify(process.env.REVISION)
        })
        ```
    - Add `SENTRY_AUTH_TOKEN` to your gitlab repository, you can protect and mask it, we only need it for staging and production (which is based on the branches develop/master mostly, which are usually protected branches).
       - Checkout the gitlab documentation how to do it: https://docs.gitlab.com/ee/ci/variables/#create-a-custom-variable-in-the-ui
       - Open the [custom Gitlab Integration in Sentry](https://sentry.conlance.org/settings/conlance/developer-settings/gitlab-ci-integration-97cd71/) and copy the token (please don't use personal API tokens as they are tied to your account)
    - Add a job to your .gitlab-ci.yml:
        ```yaml
        release_sentry:
            stage: release
            image: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
            script:
                - apk add bash curl
                - ./sentry-sourcemaps.sh
            only:
                - develop
                - master
        ```
    - Make sure your **production assets** are in place in your job (the paths depend on your setup, for webpacker it would be by default `public/packs`, for Vite `public/vite/`)
    - Add the upload bash script (sentry-sourcemaps.sh) to your project root:
        ```bash
        # install sentry-cli via yarn
        yarn install @sentry/cli

        # you can make the output more verbose for debugging reasons
        # SENTRY_LOG_LEVEL=debug

        # create sentry release and upload sourcemaps
        ./node_modules/.bin/sentry-cli releases new $CI_COMMIT_SHORT_SHA
        ./node_modules/.bin/sentry-cli releases files $CI_COMMIT_SHORT_SHA delete --all
        ./node_modules/.bin/sentry-cli releases files $CI_COMMIT_SHORT_SHA upload-sourcemaps --rewrite --validate --ext map public
        ./node_modules/.bin/sentry-cli releases finalize $CI_COMMIT_SHORT_SHA
        ```
    - Add a `.sentryclirc` file to your project root containing:
        ```
        [defaults]
        url=https://sentry.conlance.org/
        org=conlance
        project=mandacom # use your project name here

        [auth]
        token=$SENTRY_AUTH_TOKEN
        ```
    - Deploy and check if everything works by producing a JS error. Things to check:
        - There's a new release with the source maps (check the artifacts section, this should be there after the `release_sentry` job is done)
        - The issue is associated with the new release, the environment tag is set (to `staging` or `production`)
        - You should see readable (unminified) JS code in the Issue, which you can use to debug

    **Info**
    - It also works without uploading the sourcemaps (step 5.) however this is very useful because it makes debugging JS stuff much easier.
    - If you find a more convenient way to do this, feel free to update this section.
    - You can checkout the implementation in our [mandacom Rails project](https://gitlab.conlance.org/conlance/mandacom).

## How to exchange DSN credentials

Usually there are three places where you could find DSN credentials (those are the secrets needed for an application to send events to [our Sentry](http://sentry.conlance.org)).

1. Rails credentials -> you have to get the master key (please ask Devops people when in doubt), adapt the credentials in the repo (`rails credentials:edit` things) and do a deployment
2. .env files -> they are usually maintained in our Ansible (please ask in the Devops Inbox channel if someone can help), no deployment necessary but web-server has to be restarted to reload the new environment variables
3. settings ([config gem](https://rubygems.org/gems/config)) -> similar to .env

ℹ️ Please don't add the credentials in plain text to your repo

## Which sentry alerts should I define for my project?

Right now we haven't decided on a company process regarding sentry alert configurations.  
To create an alert go to the project#show and click on alerts.  
Here you can add all desired alerts by using the conditions WHEN and IF.  
Next define an an action (THEN) and an ACTION INTERVAL for the conditions.

**HINT**: The ACTION INTERVAL will define how often an email notification will be sent to the defined recipients, so be extra careful or devs will get annoyed pretty quickly 🤣

So far we recommend to have at least two alerts that fit almost all projects, an alert for new issues and a reminder alert:
### 'new issue' alert:

- **WHEN**: A new issue is created  
- **IF**: -  
- **THEN**: Send a notification to Team #team_name  
- **ACTION INTERVAL**: 30 days  

### 'reminder' alert:

- **WHEN**: -  
- **IF**: The issue is older than 2 days AND The issue is assigned to No One  
- **THEN**: Send a notification to Team #team_name  
- **ACTION INTERVAL**: 24 hours
