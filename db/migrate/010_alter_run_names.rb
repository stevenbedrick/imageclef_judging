class AlterRunNames < ActiveRecord::Migration
  def self.up
        add_column :run_names, :run_name, :string
        execute "ALTER TABLE run_names ADD CONSTRAINT uniq_file_name UNIQUE (file_name)"
  end


  def self.down
    remove_column :run_names, :run_name
  
  end
end
