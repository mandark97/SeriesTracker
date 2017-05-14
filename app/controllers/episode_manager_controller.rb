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

  # toggle all episodes from a season
  def toggle_all
    f_tvshow = current_user.followed_tvshows.find_by(tvshow_id: params[:show_id])
    episodes = f_tvshow.episodes
    del = false
    if Episode.where(tvshow_id: f_tvshow.tvshow.id, season: params[:season_nr]).count == f_tvshow.episodes.where(season: params[:season_nr]).count
      del = true
    end
    Episode.where(tvshow_id: f_tvshow.tvshow_id, season: params[:season_nr]).each do |ep|
      e = f_tvshow.followed_episodes.find_by(episode_id: ep.id)
      if del
        unless e.nil?
          e.delete
        end
      elsif !episodes.include?(ep)
        episodes << ep
      end
    end
    redirect_to tvshow_details_path id: params[:show_id], anchor: "season#{ params[:season_nr] }"
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

    redirect_to tvshow_details_path id: episode.tvshow_id, anchor: "season#{ episode.season }"
  end

  def episode_details
    @episode = Episode.find(params[:id])
  end
end
