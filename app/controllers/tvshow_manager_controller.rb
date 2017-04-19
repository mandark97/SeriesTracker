class TvshowManagerController < ApplicationController
  before_action :logged, only: :follow
  include TvshowManagerHelper
  require 'omdbapi'

  def index
    #@tv=Tvshow.add_or_create_by_title('The Flash')

  end

  def show
    @answer = OMDB.client.search(params[:title])
    if !answer_test(@answer)
      redirect_to root_path
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
      puts 'w/e'
    end

    redirect_to action: 'show_tvshows'
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

      current_user.followed_tvshows.find(episode.tvshow_id).episodes << episode

    rescue
      puts 'magie'
    end
    @followedstuff = current_user.followed_tvshows
  end

  def logged
    if current_user == nil
      redirect_to root_path
    end
  end
end
