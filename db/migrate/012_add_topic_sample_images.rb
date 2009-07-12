class AddTopicSampleImages < ActiveRecord::Migration
  def self.up
    create_table :topic_sample_images do |t|
        t.string :image_name
        t.integer :topic_id
    end
 execute 'ALTER TABLE topic_sample_images ADD CONSTRAINT fk_topic_sample_images_topics FOREIGN KEY ( topic_id ) REFERENCES topics( id ) '
end

  def self.down
     drop_table :topic_sample_images
  end
end
