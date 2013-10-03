class TagTopic < ActiveRecord::Base
  attr_accessible :topic

  has_many(
  :tags,
  :class_name => 'Tag',
  :foreign_key => :tag_topic_id,
  :primary_key => :id
  )
end
