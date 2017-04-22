class AddMoreColumnsToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :season, :integer
    add_column :episodes, :director, :string
    add_column :episodes, :writer, :string
    add_column :episodes, :actors, :string
    add_column :episodes, :plot, :string
    add_column :episodes, :poster, :string
    add_column :episodes, :awards, :string
  end
end
