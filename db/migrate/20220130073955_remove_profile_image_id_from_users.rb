class RemoveProfileImageIdFromUsers < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :profile_image_id
      end

  def down
    add_column :users, :profile_image_id, :integer
  end
end
