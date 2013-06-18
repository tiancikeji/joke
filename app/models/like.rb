class Like < ActiveRecord::Base
  attr_accessible :myjoke_id, :user_id
  belongs_to :myjoke
  belongs_to :user
end
