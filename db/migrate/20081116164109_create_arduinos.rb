class CreateArduinos < ActiveRecord::Migration
  def self.up
    create_table :arduinos do |t|
	  t.column :ip_address, :string, :null => false
	  t.column :drb, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :arduinos
  end
end
