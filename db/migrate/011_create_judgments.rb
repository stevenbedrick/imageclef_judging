class CreateJudgments < ActiveRecord::Migration
  def self.up
    create_table :judgments do |t|
      t.integer :user_id
      t.integer :pool_entry_id
      t.integer :relevance
      t.timestamps
    end
     execute 'ALTER TABLE judgments ADD CONSTRAINT fk_judgments_user FOREIGN KEY ( user_id ) REFERENCES users( id ) '
     execute 'ALTER TABLE judgments ADD CONSTRAINT fk_judgments_pool_entry FOREIGN KEY ( pool_entry_id ) REFERENCES pool_entries( id ) '
  end

  def self.down
    drop_table :judgments
  end
end
