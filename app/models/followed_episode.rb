class FollowedEpisode < ApplicationRecord
  has_many :episodes
  belongs_to :followed_tvshow
end
