class ChangeUserIdToUidLikes < ActiveRecord::Migration
  def up
    remove_column :likes, :user_id
    add_column :likes, :uid, :string
  end

  def down
  end
end
