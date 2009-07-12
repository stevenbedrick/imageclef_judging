class CreateTopicSampleImages < ActiveRecord::Migration
  def self.up
    create_table :topic_sample_images do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :topic_sample_images
  end
end
