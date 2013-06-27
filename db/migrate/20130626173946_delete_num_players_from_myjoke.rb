class DeleteNumPlayersFromMyjoke < ActiveRecord::Migration
  def up
    remove_column :myjokes, :num_players
  end

  def down
  end
end
