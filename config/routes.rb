Rails.application.routes.draw do
  resources :comments
  get 'cities/show'
  get 'contact', to: 'contact#contact'
  get 'team', to: 'team#team'
  get 'welcome/:first_name', to: 'welcome#index', as: 'welcome'
  get 'user/:id', to: 'user#show', as: 'user'
  root 'welcome#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'


  resources :users
  resources :gossips
  resources :gossips do
    resources :comments
  end

  resources :cities, only: [:show]

  resources :sessions, only: [:new, :create, :destroy]
  delete 'logout', to: 'sessions#destroy'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
