class AddNumPlaysToMyjoke < ActiveRecord::Migration
  def change
    add_column :myjokes, :num_plays, :integer
  end
end
