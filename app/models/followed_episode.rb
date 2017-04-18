class FollowedEpisode < ApplicationRecord
  belongs_to :episode
  belongs_to :followed_tvshow
  validates_uniqueness_of :episode_id, :scope => :followed_tvshow_id
end
