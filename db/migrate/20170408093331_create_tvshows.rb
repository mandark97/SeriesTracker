class CreateTvshows < ActiveRecord::Migration[5.0]
  def change
    create_table :tvshows do |t|
      t.string :imdb_id, index: true, unique: true
      t.string :title
      t.integer :year
      t.string :rated
      t.date :released
      t.string :runtime
      t.string :genre
      t.string :director
      t.string :writer
      t.string :actors
      t.text :plot
      t.string :poster
      t.float :imdb_rating
      t.integer :imdb_votes
      t.integer :total_seasons

      t.timestamps
    end

  end
end
