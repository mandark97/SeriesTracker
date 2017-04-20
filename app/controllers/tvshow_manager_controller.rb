# documentation
class TvshowManagerController < ApplicationController
  before_action :logged, only: :follow
  include TvshowManagerHelper
  require 'omdbapi'

  def index
    # @tv=Tvshow.add_or_create_by_title('The Flash')
  end

  def show
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

  def follow
    serial = Tvshow.add_or_create(params[:imdb_id])
    for i in 1..serial.total_seasons
      season = OMDB.client.id(serial.imdb_id, season: i.to_s)
      season.episodes.each do |ep|
        ex = Episode.find_or_create_by(imdb_id: ep.imdb_id) do |episode|
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
      redirect_to action: 'show',
                  title: serial.title,
                  message_text: "An error occured while adding #{ serial.title } to your Watchlist",
                  message_type: "alert-danger"
      return
    end

    redirect_to action: 'show',
                title: serial.title,
                message_text: "#{ serial.title } was added successfully to your Watchlist",
                message_type: "alert-success"
  end

  def show_tvshows
    @shows = current_user.tvshows
  end

  def show_episodes
    @episodes = Episode.where(tvshow_id: params[:id])
  end

  def mark_episode
    episode = Episode.find(params[:ep])
    puts episode
    begin

      current_user.followed_tvshows.find_by(tvshow_id: episode.tvshow_id).episodes << episode
    rescue
      puts 'magie'
    end
    @followedstuff = current_user.followed_tvshows
  end

  def logged
    if current_user == nil?
      redirect_to root_path
    end
  end
end
