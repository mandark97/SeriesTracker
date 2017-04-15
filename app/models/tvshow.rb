class Tvshow < ApplicationRecord
  has_many :episodes
  has_many :followed_tvshows
  has_many :users, through: :followed_tvshows
  validates :imdb_id, uniqueness: true

  KEYS = [:type, :language, :answer, :country, :awards, :metascore]
  def self.add_or_create(imdb_id)
    unless (ret=Tvshow.all.find_by(imdb_id: imdb_id))
      tvshow = OMDB.id(imdb_id)
      ret=common_create(tvshow)
    end
    ret
  end

  def self.add_or_create_by_title(title)
    ret =nil
    unless (ret=Tvshow.all.find_by(title: title))
      tvshow = OMDB.client.title(title)
      ret=common_create(tvshow)
    end
    ret

  end

  def self.common_create(tvshow)
    return Tvshow.create(tvshow.except(*KEYS))
  end
end
