class Arduino < ActiveRecord::Base

  attr_accessible :xmpp_account, :xmpp_password

  def Arduino.generate_device_key
    Time.now.to_f.to_s.gsub(".", "") # Timestamp with milliseconds
  end

end
