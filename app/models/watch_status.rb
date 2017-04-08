class WatchStatus < ApplicationRecord
  belongs_to :watch_list
  belongs_to :episode
end
