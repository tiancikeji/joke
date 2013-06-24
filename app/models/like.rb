class Like < ActiveRecord::Base
  attr_accessible :myjoke_id, :uid
  belongs_to :myjoke

  validates :uid, :presence => true

  def num_likes
    Like.where(:myjoke_id => :myjoke_id).count
  end
end
