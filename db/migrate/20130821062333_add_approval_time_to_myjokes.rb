class AddApprovalTimeToMyjokes < ActiveRecord::Migration
  def change
    add_column :myjokes, :approval_time, :datetime
  end
end
