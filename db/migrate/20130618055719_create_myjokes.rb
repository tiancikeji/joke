class CreateMyjokes < ActiveRecord::Migration
  def change
    create_table :myjokes do |t|
      t.string :name
      t.string :picture_url
      t.string :audio_url
      t.integer :user_id
      t.integer :approved, :default => 0

      t.timestamps
    end
  end
end
