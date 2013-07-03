class AddLengthToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :length, :integer
  end
end
