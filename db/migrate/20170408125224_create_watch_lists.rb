class CreateWatchLists < ActiveRecord::Migration[5.0]
  def change
    create_table :watch_lists do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
