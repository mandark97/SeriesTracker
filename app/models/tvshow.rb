class Tvshow < ApplicationRecord
  has_many :episodes
  validates :imdb_id, uniqueness: true
end
