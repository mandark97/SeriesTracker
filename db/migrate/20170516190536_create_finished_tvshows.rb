class CreateFinishedTvshows < ActiveRecord::Migration[5.0]
  def change
    create_table :finished_tvshows do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :tvshow, index: true, foreign_key: true
      t.timestamps
    end
  end
end
