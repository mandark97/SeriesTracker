class FrontendController < ApplicationController
  TV_SHOW_REMOVAL = [:type, :language, :answer, :country, :awards, :metascore]
  def index
    require 'omdbapi'
    gameofthrones=OMDB.title('Game of thrones')
    test=Tvshow.create(gameofthrones.except(*TV_SHOW_REMOVAL))
    @count=0
    for i in 1..gameofthrones.total_seasons.to_i
      ceva=OMDB.title(gameofthrones.imdb_id,{:season => i.to_s})
      ceva.episodes.each do |x|
        x[:tvshow_id]=test.id
        ep1=Episode.create(x)
        if ep1.valid?
        @count=@count+1
          end
        #ep=Episode.create(imdb_id: x.imdb_id, tvshow_id: x.tvshow_id, released: x.released, episode: x.episode, imdb_rating: x.imdb_rating,title: x.title
      end
    end
    @episodes=Episode.all
  end
end
