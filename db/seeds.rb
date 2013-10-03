# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  users = User.create([
    { name: 'Peter', email: 'fake_peter@fake.com' },
    { name: 'KK', email: 'kkfake@fake.com' }
    ])
  shortened_urls = ShortenedUrl.create([
    { submitter_id:1, short_url:"12345", long_url:"www.google.com" },
    { submitter_id:1, short_url:"23456", long_url:"www.msn.com" },
    { submitter_id:2, short_url:"2353436", long_url:"www.google.com" },
    { submitter_id:2, short_url:"126335", long_url:"www.yahoo.com" },
  ])
  tag_topics = TagTopic.create([
    {topic:"news"},
    {topic:"sports"},
    {topic:"music"}
  ])
end

