class FinishedTvshow < ApplicationRecord
  belongs_to :tvshow
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :tvshow_id
end
