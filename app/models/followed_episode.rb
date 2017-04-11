class FollowedEpisode < ApplicationRecord
  belongs_to :episode
  belongs_to :followed_tvshow
end
