class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :shortened_url_id
      t.integer :tag_topic_id

      t.timestamps
    end
  end
end
