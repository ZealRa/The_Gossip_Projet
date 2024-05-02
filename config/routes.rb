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
  post 'like/:gossip_id', to: 'gossips#like', as: 'like_gossip'


  resources :users
  resources :gossips
  resources :gossips do
    resources :comments
    member do
      post 'like', to: 'gossips#like'
      delete 'unlike', to: 'gossips#unlike'
    end
  end



  resources :cities, only: [:show]

  resources :sessions, only: [:new, :create, :destroy]
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
