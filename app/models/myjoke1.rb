class Myjoke1 < ActiveRecord::Base
  NUM_PER_PAGE = 10
  attr_accessible :approved, :audio_url, :name, :picture_url, :uid, :description, :length,
    :full_picture_url, :full_audio_url, :num_plays
  
  mount_uploader :picture_url, PictureUploader

  mount_uploader :audio_url, FileUploader

  #belongs_to :user
  has_many :likes
  
  validates :uid, :presence => true
  before_save :set_full_url

  def self.getJokes(uid, page = 0, date = nil)
    query = "SELECT my.*, my.id as id, (like.id) as is_like, (SELECT COUNT(*) FROM likes as like_inner WHERE like_inner.myjoke_id = my.id) AS num_likes FROM myjokes AS my left join likes AS like ON my.id = like.myjoke_id AND like.uid = '#{uid}' "
    query += "WHERE (like.id IS null OR like.uid <> '') "
    if not date.nil?
      date = Time.parse(date + " 00:00 UTC")
      query += "AND (my.created_at > '#{date.yesterday.to_s(:db)}' AND my.created_at < '#{date.tomorrow.to_s(:db)}') "
    end
    query += "ORDER BY my.created_at DESC LIMIT #{NUM_PER_PAGE} "
    if not page.nil? and page.to_i > 1
      query += "OFFSET #{(page.to_i - 1) * NUM_PER_PAGE}"
    end
    ActiveRecord::Base.connection.select_all(query)
  end
  
  def set_full_url
    self.full_picture_url = self.picture_url.url
    self.full_audio_url = self.audio_url.url
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
