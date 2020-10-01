Rails.application.routes.draw do
  # USER
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/autologin', to: 'users#autologin'

  # PORTFOLIOS
  resources :portfolios

  # ACTIVITIES
  resources :activities
  post '/sell', to: 'activities#sell'

  # STOCKS
  resources :stocks
  get '/quotes/:queries', to: 'stocks#quotes'
  get '/intraday/:ticker', to: 'stocks#intraday'
  get '/week/:ticker', to: 'stocks#week'
  get '/historical/:ticker', to: 'stocks#historical'

  # FUNDS
  resources :funds
  post '/deposit', to: 'funds#deposit'
  post '/withdraw', to: 'funds#withdraw'

end
