class Episode < ApplicationRecord
  belongs_to :tvshow
  belongs_to :followed_episode
  validates :imdb_id, uniqueness: true

end
