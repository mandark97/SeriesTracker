class Tvshow < ApplicationRecord
  has_many :episodes
  has_many :users, through: :followed_tvshows
  validates :imdb_id, uniqueness: true
end
