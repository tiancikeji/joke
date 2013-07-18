class AddFileSizesToMyjoke < ActiveRecord::Migration
  def change
    add_column :myjokes, :picture_size_in_b, :float
    add_column :myjokes, :audio_size_in_b, :float
  end
end
