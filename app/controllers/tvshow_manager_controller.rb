class TvshowManagerController < ApplicationController
  before_action :logged, only: :add_to_watchlist
  include TvshowManagerHelper

  # return a view with a search bar and
  # TO DO: a list with the top rated tv shows by users
  def index
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
  def add_watchlist
    serial = Tvshow.add_or_create(params[:imdb_id])
    for i in 1..serial.total_seasons
      season = OMDB.client.id(serial.imdb_id, season: i.to_s)
      season.episodes.each do |ep|
        puts ep
        Episode.find_or_create_by(imdb_id: ep.imdb_id) do |episode|
          episode.tvshow_id = serial.id
          episode.title = ep.title
          episode.episode = ep.episode
          episode.imdb_rating = ep.imdb_rating
          episode.released = ep.released
        end
      end
    end

    begin
      current_user.tvshows << serial
    rescue
      redirect_to action: 'search',
                  title: serial.title,
                  message_text: "An error occured while adding #{ serial.title } to your Watchlist",
                  message_type: "alert-danger"
      return
    end

    redirect_to action: 'search',
                title: serial.title,
                message_text: "#{ serial.title } was added successfully to your Watchlist",
                message_type: 'alert-success'
  end

  # return a view displaying a user's watchlist
  def show_watchlist
    @tvshows_list = current_user.tvshows
  end

  # return a view containing all the details for a tv show
  # and a list for each season with it's coresponding episodes
  def tvshow_details
    @tvshow = Tvshow.find(params[:id])
  end

  # marks an episode as watched and redirects them
  # to the tvshow_details view
  def mark_episode
    episode = Episode.find(params[:id])

    begin
      current_user.followed_tvshows.find_by(tvshow_id: episode.tvshow_id).episodes << episode
    rescue
      redirect_to action: 'tvshow_details',
                  id: episode.tvshow_id,
                  message_text: 'An error occurred while marking the episode as watched',
                  message_type: 'alert-danger'
      return
    end
    redirect_to action: 'tvshow_details',
                id: episode.tvshow_id
  end

  def logged
    if current_user == nil?
      redirect_to root_path
    end
  end
end
