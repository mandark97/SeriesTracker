class Episode < ApplicationRecord
  belongs_to :tvshow
  validates :imdb_id, uniqueness: true

end
