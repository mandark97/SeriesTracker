Rails.application.routes.draw do
  get 'welcome/index'

  get '/auth/:provider/callback', to: 'sessions#create'

  root to: 'tvshow_manager#index', as: 'index'
  get 'tvshow_manager/search', as: 'search'
  get 'tvshow_manager/add_watchlist/:imdb_id', to: 'tvshow_manager#add_watchlist', as: 'add_watchlist'
  get 'tvshow_manager/show_watchlist', as: 'show_watchlist'
  get 'tvshow_manager/tvshow/:id', to: 'tvshow_manager#tvshow_details', as: 'tvshow_details'
  get 'tvshow_manager/mark_episode/:id', to: 'tvshow_manager#mark_episode', as: 'mark_episode'

  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end