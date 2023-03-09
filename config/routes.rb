Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  get 'dashboard/index'
  root "static_pages#home"
  get "help", to: "static_pages#help"
  get "about" ,to: "static_pages#about"
  get "contact" ,to: "static_pages#contact"
  get "signup" ,to: 'users#new'
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "dashboard", to: "dashboard#index"
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :toys
end
