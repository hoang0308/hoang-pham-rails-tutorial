Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help' #tao ra 2 root la help_path va help_url :  'http://www.example.com/help'
  get '/about', to: 'static_pages#about'  #, as: 'hoang'   #(thay doi ten path)
  get '/contact', to: 'static_pages#contact'
  get '/sigup', to: 'users#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
