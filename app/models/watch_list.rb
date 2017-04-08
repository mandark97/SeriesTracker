class WatchList < ApplicationRecord
  belongs_to :user
  has_many :episodes, through: :watch_statuses
end
