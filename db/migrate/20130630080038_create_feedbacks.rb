class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :uid
      t.string :url

      t.timestamps
    end
  end
end
