Rails.application.routes.draw do
  get "/admin", to: "admin/dashboard#index", as: "admin_root"
  root "home#index"
  get 'home/index'
  get 'home/my_purchase'

  get '/auth/:provider/callback', to: 'oauth#create', as: "google_sign_in"
  get '/auth/failure' => 'oauth#failure' 

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'registrations#new'
  post '/signup' => 'registrations#create'

  resources :password_resets
  resources :users, only: [:index, :show, :edit, :update]
  resources :products, only: [:index, :show]

  namespace :admin do
    get 'dashboard/index'
    resources :products, :users
  end

  resources :transactions, only: [:new, :create]
end
