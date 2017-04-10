class WatchedEpisode < ApplicationRecord
  belongs_to  :watched_tv_show
  belongs_to :episode
end
