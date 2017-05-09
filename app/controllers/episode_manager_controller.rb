class EpisodeManagerController < ApplicationController
  before_action :check_login

  # marks an episode as watched and redirects them
  # to the tvshow_details view
  def follow
    episode = Episode.find(params[:id])

    begin
      current_user.followed_tvshows.find_by(tvshow_id: episode.tvshow_id).episodes << episode
    rescue
      redirect_to tvshow_details_path id: episode.tvshow_id,
                                      message_text: 'An error occurred while marking the episode as watched',
                                      message_type: 'alert-danger'
      return
    end
    redirect_to tvshow_details_path id: episode.tvshow_id, anchor: "season#{ episode.season }"
  end

  # marks an episode as unwatched and redirects them
  # to the tvshow_details view
  def unfollow
    episode = Episode.find(params[:id])
    followed_tvshow = current_user.followed_tvshows.find_by(tvshow_id: episode.tvshow_id)
    followed_episode = followed_tvshow.followed_episodes.find_by(episode_id: params[:id])

    begin
      followed_episode.delete
    rescue
      redirect_to tvshow_details_path id: episode.tvshow_id,
                                      message_text: 'An error occurred while marking the episode as unwatched',
                                      message_type: 'alert-danger'
      return
    end

    redirect_to tvshow_details_path id: followed_tvshow.id, anchor: "season#{ episode.season }"
  end

  def episode_details
    @episode = Episode.find(params[:id])
  end
end
