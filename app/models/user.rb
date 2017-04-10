class User < ApplicationRecord
  has_many :tvshows, through: :followed_tvshows
end
