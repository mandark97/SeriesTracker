Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :sessions, only: [:create, :destroy]
  resources :tweets
  root to: 'tvshow_manager#index'
  get 'tvshow_manager/search', as: 'search'
  get 'tvshow_manager/follow/:imdb_id', to: 'tvshow_manager#follow', as: 'follow_tvshow'
  get 'tvshow_manager/unfollow/:id', to: 'tvshow_manager#unfollow', as: 'unfollow_tvshow'
  get 'tvshow_manager/watchlist', as: 'watchlist'
  get 'tvshow_manager/tvshow/:id', to: 'tvshow_manager#tvshow_details', as: 'tvshow_details'
  get 'tvshow_manager/add_rating/:id', to: 'tvshow_manager#add_rating', as: 'rate_tvshow'
  get 'tvshow_manager/mark_finished/:id', to: 'tvshow_manager#mark_finished', as: 'mark_finished'
  get 'tvshow_manager/finished_tvshows', as: 'finished_tvshows'

  post 'episode_manager/new', as: 'new_episode'
  get 'episode_manager/follow/:id', to: 'episode_manager#follow', as: 'follow_episode'
  get 'episode_manager/toggle_all/:season_nr :show_id', to: 'episode_manager#toggle_all', as: 'toggle_all'
  get 'episode_manager/unfollow/:id', to: 'episode_manager#unfollow', as: 'unfollow_episode'
  get 'episode_manager/episode/:id', to: 'episode_manager#episode_details', as: 'episode_details'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  resources :episodes do
    resources :comments, module: :episodes
  end

end
