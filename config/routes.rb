Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help' #tao ra 2 root la help_path va help_url :  'http://www.example.com/help'
  get '/about', to: 'static_pages#about'  #, as: 'hoang'   #(thay doi ten path)
  get '/contact', to: 'static_pages#contact'
  get '/sigup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/users/sendusers', to: 'users#send_user'
  resources :users
  resources :account_activations, only: [:edit]
end
