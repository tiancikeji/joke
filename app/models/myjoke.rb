require 'taglib'
class Myjoke < ActiveRecord::Base
  NUM_PER_PAGE = 10
  attr_accessible :approved, :audio_url, :name, :picture_url, :uid, :description, :length,
    :full_picture_url, :full_audio_url, :num_plays, :picture_size_in_b, :audio_size_in_b, :approval_time
  
  mount_uploader :picture_url, PictureUploader

  mount_uploader :audio_url, FileUploader

  #belongs_to :user
  has_many :likes
  
  validates :uid, :presence => true
  before_save :set_full_url
  before_save :set_audio_length
  before_save :set_file_size

  def self.getJokes(uid, page = 0, date = nil, dir = 0)
    query = "select c.*,  CASE WHEN l.uid IS NULL THEN 0 ELSE 1 END as is_like from (SELECT m.*, count(l.id) as num_likes1 from (select * from myjokes where "
     if not date.nil?
       query += "date_format(approval_time, '%Y%m%d')"
       query += (dir.to_i==0?" >= ":" <= ")
       query += "'#{date}' and "
     end
      query += "approved<>0) as m left join likes as l on m.id=l.myjoke_id group by m.id) as c left join (select * from likes where uid='#{uid}') as l on c.id=l.myjoke_id order by c.updated_at DESC limit 10"

    # if not date.nil?
      # date = Time.parse(date + " 00:00 UTC")
      # query += "AND (my.created_at > '#{date.yesterday.to_s(:db)}' AND my.created_at < '#{date.tomorrow.to_s(:db)}') "
    # end
    ActiveRecord::Base.connection.select_all(query)
  end

  
  def set_file_size
    if not self.picture_url.nil? and self.picture_size_in_b.nil?
       self.assign_attributes(:picture_size_in_b => self.picture_url.size.to_f)
    end
    if not self.audio_url.nil? and self.audio_size_in_b.nil?
       self.assign_attributes(:audio_size_in_b => self.audio_url.size.to_f)
    end
  end
  
  def set_full_url
    self.assign_attributes(:full_picture_url => self.picture_url.url,
      :full_audio_url => self.audio_url.url)
   # self.full_picture_url = self.picture_url.url
   # self.full_audio_url = self.audio_url.url
  end
  
  def set_audio_length
    if self.length <= 0 and not self.audio_url.nil? and not self.audio_url.path.nil?
      TagLib::MPEG::File.open(self.audio_url.path) do |file|
        self.assign_attributes(:length => file.audio_properties.length)
      end
    end
  end

def is_like(uid)
  Like.where(:uid => uid, :myjoke_id => self.id).count > 0
  end


def as_json(options)
  super( :except => [ :audio_url, :picture_url] ).merge(
      {
      :audio_url => self.audio_url.url,
      :picture_url => self.picture_url.url,
#:is_like => self.is_like,
#:num_likes => self.num_likes,
      :num_plays => self.num_plays
#:created_at => self.created_at.time.in_time_zone('UTC')
      })
end

end
