class Tag < ActiveRecord::Base
  attr_accessible :shortened_url_id, :tag_topic_id
  belongs_to(
    :topic,
    :class_name => 'TagTopic',
    :foreign_key => :tag_topic_id,
    :primary_key => :id
  )
  belongs_to(
    :url,
    :class_name => 'ShortenedUrl',
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )

  def self.most_popular_in(topic)
    SELECT COUNT(*)
    FROM tags
      JOIN visits
        ON tags.shortened_url_id = visits.shortened_url_id
    WHERE tag_topic_id = 1
    GROUP BY tags.shortened_url_id

    Tag.count(:tag_id, {
                 :distinct => true,
                 :conditions => "created_at > '#{10.minutes.ago}'"
                 })
  end
end
