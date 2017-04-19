Rails.application.routes.draw do
  match 'tweets' => 'tweets#index', via: [:get, :post]
  match 'tweets/index' => 'tweets#index', via: [:get, :post]
  match 'tweets/show' => 'tweets#show', via: [:get, :post]
  match 'tweets/new' => 'tweets#new', via: [:get, :post]
  match 'tweets/edit' => 'tweets#edit', via: [:get, :post]

  get '/auth/:provider/callback', to: 'sessions#create'

  root to: 'tvshow_manager#index'
  get 'tvshow_manager/show_tvshows'
  get 'tvshow_manager/show_episodes'
  get 'tvshow_manager/mark_episode'
  get '/show', to: 'tvshow_manager#show'
  get 'tvshow_manager/follow'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
