class ShortenedUrl < ActiveRecord::Base
  attr_accessible :submitter_id, :short_url, :long_url
  validates :short_url, :presence => true, :uniqueness => true
  validates :long_url, :presence => true
  validates :submitter_id, :presence => true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )

  has_many(
  :tags,
  :class_name => 'Tag',
  :foreign_key => :shortened_url_id,
  :primary_key => :id
  )

  has_many :visitors, :through => :visits, :source => :visitor, :uniq => true

  def self.random_code
    begin
      code = SecureRandom::urlsafe_base64(4) # 16
    end while ShortenedUrl.exists?(short_url:code)
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!({
      submitter_id:user.id,
      short_url:random_code,
      long_url:long_url})
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.count(:user_id, {
                 :distinct => true,
                 :conditions => "created_at > '#{10.minutes.ago}'"
                 })
  end
end
