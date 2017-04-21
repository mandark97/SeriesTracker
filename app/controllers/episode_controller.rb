class EpisodeController < ApplicationController
  protect_from_forgery :except => :new

  def new
    ep = Episode.find_or_create_by(imdb_id: params[:imdb_id]) do |episode|
      episode.tvshow_id = params[:tvshow_id]
      episode.season = params[:season]
      episode.title = params[:title]
      episode.episode = params[:episode]
      episode.imdb_rating = params[:imdb_rating]
      episode.released = params[:released]
    end

    render :json => {}
  end
end
