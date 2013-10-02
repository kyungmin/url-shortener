class Visit < ActiveRecord::Base
  attr_accessible :user_id, :shortened_url_id
  validate :user_id, :presence => true
  validate :shortened_url_id, :presence => true
end
