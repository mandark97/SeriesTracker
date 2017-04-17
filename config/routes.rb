Rails.application.routes.draw do
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
