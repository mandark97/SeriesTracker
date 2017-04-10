class CreateWatchedEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :watched_episodes do |t|
      t.belongs_to :watched_tv_show, index:true, foreing_key: true
      t.belongs_to :episode, index:true, foreing_key: true
      t.timestamps
    end
  end
end
