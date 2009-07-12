class CreateRunNames < ActiveRecord::Migration
  def self.up
    create_table :run_names do |t|
          t.integer :group_id
          t.text :file_name
          t.string :language
          t.boolean :visual
          t.boolean :mixed
          t.boolean :text
          t.boolean :automatic
          t.boolean :manual
          t.boolean :feedback
          t.timestamps
    end
    execute 'ALTER TABLE run_names ADD CONSTRAINT fk_run_names_groups FOREIGN KEY ( group_id ) REFERENCES groups( id ) '
  end

  def self.down
  end
end
