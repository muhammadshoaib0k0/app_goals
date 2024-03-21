# middleman + webpack
this page will guide you through the creation of a [middlemanapp](https://middlemanapp.com) project with webpack 4 and bootstrap

## helpful links

* [middleman documentation](https://middlemanapp.com/basics/install/)

* [middleman and webpack](https://dev.to/lxxxvi/middleman-tailwindcss-webpack-ap3)

* [webpack and bootstrap](https://stevenwestmoreland.com/2018/01/how-to-include-bootstrap-in-your-project-with-webpack.html)

* [webpack config](https://dev.to/pixelgoo/how-to-configure-webpack-from-scratch-for-a-basic-website-46a5)

* [example: mandacom.de repo](https://gitlab.conlance.org/conlance/mandacom_website)

## creating a middleman project

* use the latest version of [ruby](../development-issues/ruby-setup.md)

* create a repo
  ```
    gem install middleman
    middleman init my_project
    cd my_project
    middleman server
  ```
* view the website at http://localhost:4567

* add livereload & slim to the **Gemfile** and run `bundle install`
  ```ruby
    gem 'middleman-livereload'
    gem 'slim', '~> 4.1'
  ```

## using webpack

* add npm packages
  ```
    npm init -y
    npm install webpack webpack-cli --save-dev
  ```

* install the required loaders and postcss plugins
  ```
    npm install autoprefixer css-loader exports-loader file-loader mini-css-extract-plugin postcss postcss-import  postcss-loader resolve-url-loader sass-loader style-loader --save-dev
  ```

* create a webpack configuration file **webpack.config.js**
  ```javascript
  const MiniCssExtractPlugin = require('mini-css-extract-plugin');

  module.exports = {
    mode: 'production',
    plugins: [
      new MiniCssExtractPlugin()
    ],
    entry: {
      application: './source/javascripts/site.js',
      styles: './source/stylesheets/site.css.sass',
    },
    output: {
      path: __dirname + '/.tmp/dist',
      filename: '[name].js',
    },
    module: {
      rules: [
        {
          //--- rule for sass ---
          test: /\.s[ac]ss$/i,
          exclude: /node_modules/,
          use: [
            {
              loader: 'style-loader'
            },
            {
              loader: MiniCssExtractPlugin.loader,
              options: {
                hmr: process.env.NODE_ENV === 'development',
              },
            },
            {
              loader: 'css-loader'
            },
            {
              loader: 'postcss-loader',
              options: {
                plugins: function () {
                  return [
                    require('postcss-import'),
                    require('autoprefixer')
                  ];
                }
              }
            },
            {
              loader: 'resolve-url-loader'
            },
            {
              loader: 'sass-loader',
              options: {
                implementation: require('sass'),
                sourceMap: true
              },
            }
          ]
        },
        {
         //--- rule for images ---
         test: /\.(png|jpe?g|gif|svg)$/,
         use: [
            {
              loader: 'file-loader',
              options: {
                outputPath: 'images'
              }
            }
          ]
        },
        {
          //--- rule for fonts ---
          test: /\.(woff|woff2|ttf|otf|eot)$/,
          use: [
             {
               loader: 'file-loader',
               options: {
                 outputPath: 'fonts'
             }
           }
         ]
        }
      ]
    }
  }
  ```
* activate webpack as an `:external_pipeline` in **config.rb**
  ```ruby
  activate :external_pipeline,
    name: :webpack,
    command: build? ? './node_modules/webpack/bin/webpack.js --bail' : './node_modules/webpack/bin/webpack.js --watch -d --color',
    source: '.tmp/dist',
    latency: 1

  activate :autoprefixer do |prefix|
    prefix.browsers = "last 2 versions"
  end

  activate :i18n, :langs => [:de]
  activate :livereload

  page '/*.xml', layout: false
  page '/*.json', layout: false
  page '/*.txt', layout: false

  require 'uglifier'

  configure :build do
    activate :minify_css
    activate :minify_javascript, compressor: -> { Uglifier.new(harmony: true) }
    activate :relative_assets
  end
  ```

* change stylesheet and javascript paths in **source/layouts/layout.slim**
  ```slim
    doctype html
    html
      head
        meta charset="utf-8"
        meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"
        meta http-equiv="x-ua-compatible" content="ie=edge"

        title
          = current_page.data.title || "Project Title"

        = stylesheet_link_tag "styles", media: :all
        = javascript_include_tag "application"

      body
        = yield
  ```

* check the infos in the **package.json**, edit the main file and add a npm script
  ```json
  "main": "webpack.config.js",
  "scripts": {
    "build": "webpack"
  },
  ```

* add the following to **.gitignore**
  ```
    .tmp/*
    /tmp/*
    !/tmp/.keep

    /storage/*
    !/storage/.keep

    /node_modules
  ```

## adding bootstrap

* install bootstrap & dependencies
  ```
    npm install bootstrap jquery popper.js sass --save
  ```

* import bootstrap styles in **source/stylesheets/site.css**
  ```css
    @import "~bootstrap/scss/bootstrap";
  ```
  or in **source/stylesheets/site.css.sass**
  ```sass
    @import "../../node_modules/bootstrap/scss/bootstrap"
  ```

* import bootstrap javascript in **source/javascripts/site.js**
  ```javascript
    import 'bootstrap';
  ```

* use the `npm run build` command to build your bundle with webpack

* an example for **source/index.html.slim**, to see if bootstrap has been installed:
  ```
  ---
  title: Herzlich Willkommen
  ---

  .container
    .row.rounded.bg-primary.align-items-center.p-3.py-lg-5
      .col-12.text-center
        h1.display-3.text-white
          'FAQ
        h2.text-light
          'Fragen und Antworten

    .row.justify-content-center
      .col-12.col-lg-9.col-xl-8
        .accordion#accordionFaq
          .heading.my-3 id="faq-heading-1"
            button.btn.btn-accordion.text-dark.text-left.collapsed type="button" data-toggle="collapse" data-target="#faq-collapse-1" aria-expanded="true" aria-controls="faq-collapse-1"
              span.pl-2.h4
                ' Ist heute ein schöner Tag?
          .collapse.ml-4.ml-md-5 id="faq-collapse-1" aria-labelledby="faq-heading-1" data-parent="#accordionFaq"
            ' Ja, natürlich!
  ```

* run `middleman server` and check the web console for errors

:tada:
