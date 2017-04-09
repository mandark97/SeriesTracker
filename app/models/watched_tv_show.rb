class WatchedTvShow < ApplicationRecord
  belongs_to :user
  belongs_to :tvshow
  has_many :watched_episodes
end
