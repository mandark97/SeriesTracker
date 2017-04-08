class Episode < ApplicationRecord
  belongs_to :tvshow
  has_many :watch_lists, through: :watch_statuses
  validates :imdb_id, uniqueness: true

end
