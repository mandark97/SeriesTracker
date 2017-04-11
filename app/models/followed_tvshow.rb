class FollowedTvshow < ApplicationRecord
  belongs_to :tvshow
  belongs_to :user
  has_many :followed_episodes
end
