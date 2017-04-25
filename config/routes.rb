Rails.application.routes.draw do
  resources :products
  get 'home/index'
  root "home#index"
  get '/auth/:provider/callback', to: 'oauth#create', as: "google_sign_in"

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'registrations#new'
  post '/signup' => 'registrations#create'

  resources :password_resets

  resources :users, except: [:new, :create]
end
