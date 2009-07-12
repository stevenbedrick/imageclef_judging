class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.integer :iclef_topic_number
      t.integer :topic_set_id
      t.text :topic_text
      t.string :language
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
