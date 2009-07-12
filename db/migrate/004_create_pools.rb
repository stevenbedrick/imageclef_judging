class CreatePools < ActiveRecord::Migration
  def self.up
    create_table :pools do |t|
      t.string :pool_name
      t.text :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :pools
  end
end




