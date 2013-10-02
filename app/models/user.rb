class User < ActiveRecord::Base
  attr_accessible :name, :email
  validates :email, :presence => true, :uniqueness => true

  has_many(
    :submitted_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )
end
