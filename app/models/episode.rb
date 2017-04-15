class Episode < ApplicationRecord
  belongs_to :tvshow
  has_many :followed_episodes
  has_many :followed_tvshows, through: :followed_episodes
  validates :imdb_id, uniqueness: true

end
