require "drb"

class Arduino
  def send_message(message)
    @cl.send(message)
  end
  
  def get_messages
    @mutex.synchronize do
	  dup_queue = Array.new
	  @queue.each do |msg|
	    dup_queue << msg
	  end
	  @queue = Array.new
   	  return dup_queue
	end	
  end
  
  # false if authentication failure
  # true if auth is ok
  def connect
  	# Login
    #jid = JID::new("pmontrasio@gmail.com", "talk.google.com", "arduino")
	jid = JID.new("kit@tinkerkit.com/Testing")
    #password = "arduinopwd"
	password = "1234567890"
    @cl = Client.new(jid)
    @cl.connect
    @cl.auth(password)
	@queue = Array.new
	@cl.add_message_callback { |msg|
	  @mutex.synchronize do
		@queue << msg
	  end
	}
	return true
  rescue ClientAuthenticationFailure => e
    return false
  end
  
end


DRb.start_service("druby://localhost:9435", Arduino.new())
DRb.thread.join