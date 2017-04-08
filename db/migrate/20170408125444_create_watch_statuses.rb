class CreateWatchStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :watch_statuses do |t|
      t.belongs_to :episode, index: true, foreign_key: true
      t.belongs_to :watch_list, index: true, foreign_key: true
      t.boolean :status
      t.string :tvshow_id

      t.timestamps
    end
  end
end
