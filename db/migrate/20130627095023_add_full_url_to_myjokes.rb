class AddFullUrlToMyjokes < ActiveRecord::Migration
  def change
    add_column :myjokes, :full_audio_url, :string
    add_column :myjokes, :full_picture_url, :string
  end
end
