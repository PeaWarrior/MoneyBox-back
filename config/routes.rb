Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/autologin', to: 'users#autologin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
