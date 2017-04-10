class CreateWatchedTvShows < ActiveRecord::Migration[5.0]
  def change
    create_table :watched_tv_shows do |t|
      t.belongs_to :user, index:true, foreing_key: true
      t.belongs_to :tvshow, index:true, foreing_key: true
      t.timestamps
    end
  end
end
