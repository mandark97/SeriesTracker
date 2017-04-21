class EpisodeManagerController < ApplicationController
  protect_from_forgery :except => :new

  def new
    ep = Episode.find_or_create_by(imdb_id: params[:imdb_id]) do |episode|
      episode.tvshow_id = params[:tvshow_id]
      episode.season = params[:season]
      episode.title = params[:title]
      episode.episode = params[:episode_manager]
      episode.imdb_rating = params[:imdb_rating]
      episode.released = params[:released]
    end

    render :json => {}
  end

  # marks an episode as watched and redirects them
  # to the tvshow_details view
  def mark
    episode = Episode.find(params[:id])

    begin
      current_user.followed_tvshows.find_by(tvshow_id: episode.tvshow_id).episodes << episode
    rescue
      redirect_to tvshow_details_path id: episode.tvshow_id,
                                      message_text: 'An error occurred while marking the episode as watched',
                                      message_type: 'alert-danger'
      return
    end
    redirect_to tvshow_details_path id: episode.tvshow_id
  end

  def unmark
    followed_episode = FollowedEpisode.find(params[:id])
    tvshow_id = followed_episode.followed_tvshow.tvshow_id
    followed_episode.delete

    redirect_to tvshow_details_path id: tvshow_id
  end

end
