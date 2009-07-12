class CreateRunEntries < ActiveRecord::Migration
  def self.up
    
    create_table :run_entries do |t|
      t.column :topic_id, :integer
      t.column :record_id, :integer
      t.column :rank, :integer
      t.column :score, :float
      t.column :run_name_id, :integer
    end
    execute 'ALTER TABLE run_entries ADD CONSTRAINT fk_run_entries_topics FOREIGN KEY ( topic_id ) REFERENCES topics( id ) '
    execute 'ALTER TABLE run_entries ADD CONSTRAINT fk_run_entries_records FOREIGN KEY ( record_id ) REFERENCES records( id ) '
    execute 'ALTER TABLE run_entries ADD CONSTRAINT fk_run_entries_run_names FOREIGN KEY ( run_name_id ) REFERENCES run_names( id ) '
  end

  def self.down
    drop_table :run_entries
  end
end
