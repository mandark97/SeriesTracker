class CreateFollowedEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :followed_episodes do |t|
      t.belongs_to :followed_tvshow, index: true, foreign_key: true
      t.belongs_to :episode, index: true, foreign_key: true
      t.boolean :status
      t.timestamps
    end
  end
end
