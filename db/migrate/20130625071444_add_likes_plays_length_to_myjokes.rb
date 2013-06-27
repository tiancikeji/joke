class AddLikesPlaysLengthToMyjokes < ActiveRecord::Migration
  def change
    add_column :myjokes, :num_likes, :integer, :default => 0
    add_column :myjokes, :num_players, :integer, :default => 0
    add_column :myjokes, :length, :integer, :default =>0
  end
end
