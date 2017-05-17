class AddRatingToFollowedTvshows < ActiveRecord::Migration[5.0]
  def change
    add_column :followed_tvshows, :rating, :string
  end
end
