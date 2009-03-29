class Arduino < ActiveRecord::Base

  def Arduino.generate_device_key
    Time.now.to_f.to_s.gsub(".", "") # Timestamp with milliseconds
  end

end
