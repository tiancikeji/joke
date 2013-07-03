class Feedback < ActiveRecord::Base
  attr_accessible :uid, :url, :length

  mount_uploader :url, FeedbackUploader
end
