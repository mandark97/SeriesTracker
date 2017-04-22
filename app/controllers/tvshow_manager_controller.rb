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
  def add_watchlist
   tvshow = Tvshow.find_or_create(params[:imdb_id])
    for season_nr in 1..tvshow.total_seasons
      season = OMDB.client.id(tvshow.imdb_id, season: season_nr.to_s)
      season.episodes.each do |ep|
        post_data = {
            tvshow_id: tvshow.id,
            season: season_nr,
        }
        post_data = ep.merge({
           tvshow_id: tvshow.id,
           season: season_nr,
        })

        HTTParty.post(episode_new_url,
                      body: post_data.to_json,
                      headers: {
                          'Content-Type': 'application/json',
                          'Accept': 'application/json'
                      }
        )
      end
    end

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

  # return a view displaying a user's watchlist
  def show_watchlist
    @tvshows_list = current_user.tvshows
  end

  # return a view containing all the details for a tv show
  # and a list for each season with it's coresponding episodes
  def tvshow_details
    @f_ts = FollowedTvshow.find(params[:id])

    if params[:message_text]
      @message = {
          'text': params[:message_text],
          'type': params[:message_type]
      }
    end
  end

  private
  def check_login
    redirect_to root_path unless current_user
  end
end
