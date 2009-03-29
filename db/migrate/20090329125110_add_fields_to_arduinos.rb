require "migration_helpers"
  
class AddFieldsToArduinos < ActiveRecord::Migration

  extend MigrationHelpers

  def self.up
    add_column :arduinos, :user_id, :int
    foreign_key :arduinos, :user_id, :users

    remove_column :arduinos, :ip_address
    add_column :arduinos, :device_key, :string
    add_index :arduinos, :device_key, :unique => true
    add_column :arduinos, :xmpp_account, :string
    add_column :arduinos, :xmpp_password, :string

    user = User.new
    user.login = "march29"
    user.password = "thisisapassword"
    user.password_confirmation = "thisisapassword"
    user.email = "paolo@paolomontrasio.com"
    user.name = "This Is A User"
    user.save!

    Arduino.reset_column_information
    ar = Arduino.new
    ar.user_id = user.id
    ar.device_key = Arduino.generate_device_key
    ar.save
    
  end

  def self.down
    remove_foreign_key :arduinos, :user_id
    remove_column :arduinos, :user_id
    remove_index :arduinos, :device_key
    remove_column :arduinos, :device_key
    remove_column :arduinos, :xmpp_account
    remove_column :arduinos, :xmpp_password

    add_column :arduinos, :ip_address, :string

    User.delete_all "login = 'march29'"

  end
end
