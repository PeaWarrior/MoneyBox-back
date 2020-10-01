Rails.application.routes.draw do
  resources :funds
  resources :stocks
  resources :activities
  resources :portfolios
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/autologin', to: 'users#autologin'
  get '/quotes/:queries', to: 'stocks#quotes'
  post '/sell', to: 'activities#sell'
  get '/intraday/:ticker', to: 'stocks#intraday'
  get '/week/:ticker', to: 'stocks#week'
  get '/historical/:ticker', to: 'stocks#historical'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
