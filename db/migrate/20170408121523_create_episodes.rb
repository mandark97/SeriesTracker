class CreateEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :episodes do |t|
      t.belongs_to :tvshow, index: true, foreing_key: true
      #t.belongs_to :followed_episode, index: true, foreign_key: true
      t.string :imdb_id, index: true,unique: true
      t.string :title
      t.date :released
      t.integer :episode
      t.float :imdb_rating

      t.timestamps
    end
  end
end
