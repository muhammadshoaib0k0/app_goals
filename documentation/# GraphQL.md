# GraphQL

## What it is?
GraphQL is a query language for APIs and a runtime for executing queries. You only get the attributes you asked for and not more. It also gives you the ability to change data.

## Most important stuff:
- "types": they define the objects with all attributes. You can generate one with `rails g graphql:object model_name`; it will generate a type with fields for your attributes, but you have to check it
- "queries": by executing a query you get the data you need. Normally you'll have one query for getting one object and one query for getting all objects.
- "mutations": by executing a mutation you can change data. Normally you'll have mutations for create, update and destroy. Mutations are defined by the arguments they accept.
- "enums": they're similar to ActiveRecord::Enums. You can generate one with `rails g graphql:enum enum_name`. The values are defined with `value 'value_name'`
- "unions": they're necessary for polymorphic associations; you generate one with `rails g graphql:union association_name`. The possible Types are defined here.
- don't forget to use camelCase when executing queries and mutations
- more information: https://graphql-ruby.org/guides
- "graphiql": you can test your queries and mutations at http://localhost:3000/graphiql; there's also a 'Docs'-section where a list of all queries and mutations of the project is available

## Setup with Rails
Add to your Gemfile:
- `gem 'graphql'`
- `gem 'graphiql-rails'` in group development
- run `bundle install`
- run `rails g graphql:install` (this generates the graphql-directory with included files like the graphql-controller and necessary base-files)
- for graphiql:
  - add to `config/routes.rb`:
    ```ruby
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

    post '/graphql', to: 'graphql#execute'
    ```
  - preload assets in `config/initializers/assets.rb`:
    ```ruby
    Rails.application.config.assets.precompile += %w[graphiql/rails/application.js graphiql/rails/application.css] if Rails.env.development?
    ```
## Examples
- "query":
  ```ruby
  query {
    modelName(id: 1){
      id
      firstAttribute
      secondAttribute
    }
  }
  ```
- "mutation":
  ```ruby
  mutation {
    createModelName(
      firstAttribute: "hello"
      secondAttribute: 2
    ){
      id
      firstAttribute
      secondAttribute
    }
  }
  ```
- when executing in the code:
    ```ruby
    <<~GQL
      query {
        ...
      }
    GQL
    ```
