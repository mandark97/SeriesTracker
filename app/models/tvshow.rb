# documentation
class Tvshow < ApplicationRecord
  has_many :episodes
  has_many :followed_tvshows
  has_many :users, through: :followed_tvshows
  validates :imdb_id, uniqueness: true

  def self.add_or_create(imdb_id)
    unless (ret = Tvshow.all.find_by(imdb_id: imdb_id))
      tvshow = OMDB.client.id(imdb_id)
      ret = common_create(tvshow)
    end
    ret
  end

  def self.add_or_create_by_title(title)
    unless (ret = Tvshow.all.find_by(title: title))
      tvshow = OMDB.client.title(title)
      ret = common_create(tvshow)
    end
    ret
  end

  def self.common_create(tvshow)
    show = Tvshow.new
    show.title = tvshow[:title]
    show.imdb_id = tvshow[:imdb_id]
    show.year = tvshow[:year]
    show.rated = tvshow[:rated]
    show.released = tvshow[:released]
    show.runtime = tvshow[:runtime]
    show.genre = tvshow[:genre]
    show.director = tvshow[:director]
    show.writer = tvshow[:writer]
    show.actors = tvshow[:actors]
    show.plot = tvshow[:plot]
    show.poster = tvshow[:poster]
    show.imdb_rating = tvshow[:imdb_rating]
    show.imdb_votes = tvshow[:imdb_votes]
    show.total_seasons = tvshow[:total_seasons]
    show.save
    show
  end
end
