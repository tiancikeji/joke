require "open-uri"

class Myjoke < ActiveRecord::Base
  attr_accessible :approved, :audio_url, :name, :picture_url, :uid, :description, :length,
    :remote_picture_url_url, :remote_audio_url_url
  
  mount_uploader :picture_url, PictureUploader

  mount_uploader :audio_url, FileUploader

  #belongs_to :user
  has_many :likes
  
  validates :uid, :presence => true

  def is_like(uid)
    Like.where(:uid => uid, :myjoke_id => self.id).count > 0
  end

  def num_likes
    Like.where(:myjoke_id => self.id).count
  end

  def num_plays
    0
  end

  def as_json(options)
    super( :except => [ :audio_url, :picture_url] ).merge(
      {
        :audio_url => self.audio_url.url,
        :picture_url => self.picture_url.url,
        #:is_like => self.is_like,
        :num_likes => self.num_likes,
        :num_plays => self.num_plays
      })
  end

end
