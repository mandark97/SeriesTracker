Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'

  get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :sessions, only: [:create, :destroy]
  resources :tweets
  # creates the following paths:
      # tweets ~ tweets#index
      # new_tweet ~ tweets#new
      # edit_tweet ~ tweets#edit
      # etc.


  root to: 'tvshow_manager#index'
  get 'tvshow_manager/search', as: 'search'
  get 'tvshow_manager/follow/:imdb_id', to: 'tvshow_manager#follow', as: 'follow_tvshow'
  get 'tvshow_manager/unfollow/:id', to: 'tvshow_manager#unfollow', as: 'unfollow_tvshow'
  get 'tvshow_manager/watchlist', as: 'watchlist'
  get 'tvshow_manager/tvshow/:id', to: 'tvshow_manager#tvshow_details', as: 'tvshow_details'

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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end