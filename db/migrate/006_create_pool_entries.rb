class CreatePoolEntries < ActiveRecord::Migration
  def self.up
    create_table :pool_entries do |t|
      t.integer :pool_id
      t.integer :record_id
      t.integer :frequency
      t.integer :topic_id
      t.timestamps
    end
    execute "ALTER TABLE pool_entries  ADD CONSTRAINT fk_pool_entries_pools FOREIGN KEY (pool_id)  REFERENCES pools (id)"
    execute "ALTER TABLE pool_entries  ADD CONSTRAINT fk_pool_entries_records FOREIGN KEY (record_id)  REFERENCES records (id)"
    execute "ALTER TABLE pool_entries  ADD CONSTRAINT fk_pool_entries_topics FOREIGN KEY (topic_id)  REFERENCES topics (id)"
    execute "ALTER TABLE pool_entries  ADD CONSTRAINT uniq_pool_topic_record UNIQUE(pool_id, record_id, topic_id);"
 end

  def self.down
    drop_table :pool_entries
  end
end


