class FollowedTvshow < ApplicationRecord
  belongs_to :tvshow
  belongs_to :user
  has_many :followed_episodes
  has_many :episodes, through: :followed_episodes
end
