class Myjoke < ActiveRecord::Base
  attr_accessible :approved, :audio_url, :name, :picture_url, :user_id
end
