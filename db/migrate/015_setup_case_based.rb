class SetupCaseBased < ActiveRecord::Migration
  def self.up
    
    add_column :records, :case_based, :boolean
    
    execute "update records set case_based=FALSE"
    
    execute "insert into topic_sets (name, created_at) values ('iclef09_case_based', NOW()) "
    
    execute "insert into pools (pool_name, comments, created_at) values ('caseBased','case based' , NOW())"

    
    
  end

  def self.down
    
    
    
    remove_column :records, :case_based
  end
end
