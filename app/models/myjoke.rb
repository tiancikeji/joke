require 'taglib'
class Myjoke < ActiveRecord::Base
  NUM_PER_PAGE = 10
  attr_accessible :approved, :audio_url, :name, :picture_url, :uid, :description, :length,
    :full_picture_url, :full_audio_url, :num_plays
  
  mount_uploader :picture_url, PictureUploader

  mount_uploader :audio_url, FileUploader

  #belongs_to :user
  has_many :likes
  
  validates :uid, :presence => true
  before_save :set_full_url
  before_save :set_audio_length

  def self.getJokes(uid, page = 0, date = nil)
    query = ""
    if date.nil?
      query = "SELECT my.num_plays,my.approved, my.length, my.full_picture_url, my.full_audio_url, my.uid, my.name, my.description, my.created_at, my.id as id, CASE WHEN like.id IS NULL THEN 0 ELSE 1 END as is_like, (SELECT COUNT(*) FROM likes as like_inner WHERE like_inner.myjoke_id = my.id) AS num_likes FROM myjokes AS my left join likes AS like ON my.id = like.myjoke_id AND like.uid = '#{uid}' "
      query += "WHERE (like.id IS null OR like.uid <> '') AND my.approved <> 0 "
      query += "ORDER BY my.created_at DESC LIMIT #{NUM_PER_PAGE} "
    if not page.nil? and page.to_i > 1
      query += "OFFSET #{(page.to_i - 1) * NUM_PER_PAGE}"
    end
    else 
      query = "select c.*,  CASE WHEN l.uid IS NULL THEN 0 ELSE 1 END as is_like from (SELECT m.*, count(l.id) as num_likes from (select * from myjokes where strftime('%Y%m%d', created_at) = '#{date}') as m left join likes as l on m.id=l.myjoke_id group by m.id) as c left join (select * from likes where uid='#{uid}') as l on c.id=l.myjoke_id order by c.created_at limit 10"
    end

    # if not date.nil?
      # date = Time.parse(date + " 00:00 UTC")
      # query += "AND (my.created_at > '#{date.yesterday.to_s(:db)}' AND my.created_at < '#{date.tomorrow.to_s(:db)}') "
    # end
    ActiveRecord::Base.connection.select_all(query)
  end
  
  def set_full_url
    self.full_picture_url = self.picture_url.url
    self.full_audio_url = self.audio_url.url
  end
  
  def set_audio_length
    if self.length <= 0
      TagLib::MPEG::File.open(self.audio_url.path) do |file|
        self.update_attributes(:length => file.audio_properties.length)
        self.save!
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
