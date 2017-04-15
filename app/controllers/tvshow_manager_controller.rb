class TvshowManagerController < ApplicationController
  before_action :logged, only: :follow
  def index
    @tv=Tvshow.add_or_create_by_title('The Flash')

  end
  def show
    @response = OMDB.client.search(params[:title])
    puts @response
  end
  def follow
    serial=Tvshow.add_or_create(params[:imdb_id])
    current_user.tvshows << serial
    @shows=current_user.tvshows
  end

  def logged
    if current_user == nil
      redirect_to root_path
    end
  end
end