class Arduino < ActiveRecord::Base

  def Arduino.generate_device_key
    "THISISNOTARANDOMKEY" # just for testing
  end

end
