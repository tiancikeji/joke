class ChangeUserIdToUidMyJokes < ActiveRecord::Migration
  def up
    remove_column :myjokes, :user_id
    add_column :myjokes, :uid, :string
  end

  def down
  end
end
