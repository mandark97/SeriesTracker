class TvshowManagerController < ApplicationController
  before_action :check_login, except: :index
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
  def follow
    tvshow = Tvshow.add_or_create(params[:imdb_id])
    begin
      current_user.tvshows << tvshow
    rescue
      redirect_to action: 'search',
                  title: tvshow.title,
                  message_text: "An error occured while adding #{ tvshow.title } to your Watchlist",
                  message_type: "alert-danger"
      return
    end

    redirect_to action: 'search',
                title: tvshow.title,
                message_text: "#{ tvshow.title } was added successfully to your Watchlist",
                message_type: 'alert-success'

  end

  def unfollow
    tvshow = current_user.followed_tvshows.find_by(tvshow_id: params[:id])
    tvshow.followed_episodes.each do |episode|
      episode.destroy
    end
    tvshow.destroy
    redirect_to watchlist_path
  end

  # return a view containing all the details for a tv show
  # and a list for each season with it's coresponding episodes
  def tvshow_details
    @f_tvshow = FollowedTvshow.find_by(tvshow_id: params[:id])
    if params[:message_text]
      @message = {
          'text': params[:message_text],
          'type': params[:message_type]
      }
    end
  end

  def watchlist
    @watchlist = {
        'new_this_week': [],
        'last_episodes': [],
        'begin_watching': []
    }

    beginning_of_week = Time.current.utc.beginning_of_week
    end_of_week = Time.current.utc.end_of_week

    current_user.followed_tvshows.each do |f_tvshow|
      episode = f_tvshow.tvshow.episodes.find_by(released: beginning_of_week..end_of_week)

      if !episode.nil? #tvshow has new episode this week
        @watchlist.new_this_week << episode
      else #show last watched episode
        f_episode = f_tvshow.followed_episodes.order(:created_at).last

        if f_episode.nil? # the user hasn't begin to watch the tvshow yet
          @watchlist.begin_watching << f_tvshow.tvshow
        else
          @watchlist.last_episodes << f_episode.episode
        end
      end
    end
  end
end
