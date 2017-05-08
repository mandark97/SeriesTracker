class TvshowManagerController < ApplicationController
  before_action :check_login, except: :index
  include TvshowManagerHelper

  # return a view with a search bar and
  # TO DO: a list with the top rated tv shows by users
  def index
    if current_user
      redirect_to tvshow_manager_last_episodes_path
    end
  end

  # return a view with a search bar and the
  # api search results list
  def search
    answer = OMDB.client.search(params[:title])
    @tvshows_list = []

    if !answer_test(answer)
      @message = {
          'text': 'No results found',
          'type': 'alert-info'
      }
    else
      if params[:message_text]
        @message = {
            'text': params[:message_text],
            'type': params[:message_type]
        }
      end
      for tvshow in answer
        tvshow_answer = OMDB.client.id(tvshow.imdb_id)
        @tvshows_list.push(tvshow_answer)
      end
    end
  end

  # adds a tv shows to the user's watchlist and
  # redirects them to the show_search_results view
  def follow
    tvshow = Tvshow.add_or_create(params[:imdb_id])
    for season_nr in 1..tvshow.total_seasons
      season = OMDB.client.id(tvshow.imdb_id, season: season_nr.to_s)
      season.episodes.each do |ep|
        Episode.find_or_create(ep.imdb_id)
      end
    end

    begin
      current_user.tvshows << tvshow
    rescue
      redirect_to action: 'search',
                  title: tvshow.title,
                  message_text: "An error occured while adding #{ tvshow.title } to your Watchlist",
                  message_type: 'alert-danger'
      return
    end

    redirect_to action: 'search',
                title: tvshow.title,
                message_text: "#{ tvshow.title } was added successfully to your Watchlist",
                message_type: 'alert-success'
  end

  # return a view displaying a user's watchlist
  def watchlist
    @tvshows_list = current_user.tvshows
  end

  # return a view containing all the details for a tv show
  # and a list for each season with it's coresponding episodes
  def tvshow_details
    @f_tvshow = FollowedTvshow.find_by_tvshow_id(params[:id])

    if params[:message_text]
      @message = {
          'text': params[:message_text],
          'type': params[:message_type]
      }
    end
  end

  def episodes_of_the_week
    beginning_of_week = Time.current.utc.beginning_of_week
    end_of_week = Time.current.utc.end_of_week
    episodes_this_week = []
    current_user.followed_tvshows.each do |ftvshow|
      episode = ftvshow.tvshow.episodes.find_by(released: beginning_of_week..end_of_week)
      episodes_this_week << episode unless episode.nil?
    end
    return episodes_this_week
  end

  def last_episodes
    @last_episode = []
    current_user.followed_tvshows.each do |ftvshow|
      fepisode = ftvshow.followed_episodes.order(:created_at).last
      @last_episode << fepisode.episode unless fepisode.nil?
    end

    @episodes_this_week = episodes_of_the_week
  end
end
