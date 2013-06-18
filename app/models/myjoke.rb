class Myjoke < ActiveRecord::Base
  attr_accessible :approved, :audio_url, :name, :picture_url, :user_id
  
  mount_uploader :picture_url, PictureUploader

  mount_uploader :audio_url, FileUploader

  belongs_to :user
  has_many :likes
end
