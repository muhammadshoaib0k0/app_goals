Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  post 'tasks/:id/toggle', to: 'tasks#toggle'

  namespace :api do
    namespace :v1 do
      post 'add-todo', to: 'todo#add_todo'
      get 'get-todo', to: 'todo#get_todo'
      delete 'delete/:id', to: 'todo#destroy_todo'
      patch 'update/:id', to:  'todo#update_todo'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
