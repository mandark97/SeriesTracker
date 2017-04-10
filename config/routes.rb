Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'

  root to: 'frontend#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
