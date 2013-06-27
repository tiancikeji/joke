class AddDescriptionToMyjoke < ActiveRecord::Migration
  def change
    add_column :myjokes, :description, :string
  end
end
