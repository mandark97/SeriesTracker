class AddProviderToUsers < ActiveRecord::Migration[5.0]
  def change
    #add_column :users, :provider, :string
    add_column :users, :profile_image, :string
  end
end
