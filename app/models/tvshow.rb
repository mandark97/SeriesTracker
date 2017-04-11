class Tvshow < ApplicationRecord
  has_many :episodes
  has_many :users, through: :followed_tvshows
  validates :imdb_id, uniqueness: true

  KEYS = [:type]
  def self.add_or_create(imdb_id)
    require 'omdbapi'
    unless Tvshow.all.find_by(imdb_id)
      tvshow = OMDB.id(imdb_id)
      common_create(tvshow)
    end

    @tvshow.save
  end

  def self.add_or_create_by_title(title)
    require 'omdbapi'
    unless Tvshow.all.find_by(title)
      tvshow = OMDB.client.title(title)
      common_create(tvshow)
    end

    @tvshow.save
  end

  def self.common_create(tvshow)
    @tvshow = Tvshow.create(tvshow.except(*KEYS))
  end
end
