class AddSeasonToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :season, :integer
  end
end
