# Spina CMS

## What it is?
Spina is an excellent content management system (CMS) for creating a Ruby on Rails website with editable content. it’s a great platform to integrate into your project to make your website easily editable without the need to touch code.


## How to get started with Spina CMS :
https://spinacms.com/guides

## Technology stack:

- Ruby 2.3+
- Ruby on Rails 5+
- jQuery
- CoffeeScript
- Sass
- HAML
- Trix HTML editor

## Install and configure Spina :

Next, let’s add Spina. Open up your Gemfile and add the following:

```
  gem 'spina'
```

Save, then run the following commands:

```
bundle install
rails g spina:install
```

Follow the steps to setup your new website (for theme, You can choose default). When done, start your server again (rails s) and navigate to localhost:3000/admin in your browser. You should see the login page.

## Important Stuff :

1. 8 built-in parts that you can use to build pages:
  - Line – the most basic of all the parts, a simple textfield to store a line of text.
  - MultiLine – similar to the Line part, however instead of a simple textfield, it uses a textarea to store a multiple lines of text.
  - Text
  - Image ( Images are always display: block for version of Trix )
  - ImageCollection
  - Attachment
  - Option
  - Repeater
2. Each theme typically has a few different view templates which make up your website. By default Spina generates a homepage and show template. [How to configure a theme](https://spinacms.com/guides/themes-content/configuring-a-theme)
3. Layout parts – these are used globally.
4. Uses Trix as it’s default editor.
5. Custom pages. [How to create custom content parts](https://spinacms.com/guides/themes-content/how-to-create-custom-content-parts)
6. Uses PostgreSQL database.

## LAST RELEASE 🎉 Spina CMS v2.6.0:
  * Spina CMS now requires Ruby 2.7+
  * Added Embed generator for Trix
  * Added --silent option to install generator
  * Added --first-deploy option to install generator
  * Added spina:first_deploy task
  * Added support for different mount paths
  * Fixed routes catch all bug
  * Updated gem dependencies

## Spina Error:

If when you try to open up the admin dashboard in your browser, it just hangs and loads indefinitely, check your terminal's output. If you're getting a lot of SASS warnings/errors, you're probably using and older version of Spina. See above for the fix.

## Sprockets Error:

If you get a Sprockets error about manifest.js, just add this line to /app/assets/config/manifest.js: **//= link default/application.css**  and restart your server.

## Contact Form using Spina:

- There’s nothing in Spina for contact forms . 
- It’s trivial using a simple Rails controller though!
- It all depends on what you want that form to do, just forwarding a message is easy


