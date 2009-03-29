# TODO:
# implementare encode/decode
# cambiare il campo ip_address della tabella arduinos in device_id
# testare il server DRb
#
# chiedere a paolo@paolomontrasio.com


require 'xmpp4r/client'

include Jabber

class XmppController < ApplicationController

  #  Sends a message
  def index

    arduino = Arduino.find_by_device_key(request.headers["X_DEVICEID"])
    render :nothing => true, :status => 403 and return if arduino.nil?

    jid = JID.new("#{arduino.xmpp_account}/Arduino")
    password = arduino.xmpp_password

    # Login
#    jid = JID.new("kit@tinkerkit.com/Testing")
    #password = "arduinopwd"
#    password = "tinker"
    cl = Client.new(jid)
    cl.connect
    cl.auth(password)
	
    m = get_message(params)
	
    # Send it
    cl.send m
  end
    
  def send_message
    arduino = Arduino.find_by_device_key(request.headers["X_DEVICEID"])
    if arduino.nil?
      connected = connect_to_xmpp
    else
      connected = true
    end
    
    render :text => "false" and return unless connected
    
    m = get_message(params)
    # Send it
    drb = decode(arduino.drb)
    @sent = drb.send_message(m)
    @messages = drb.get_messages
    
  end
  
  private 
  
  def get_message(params)
    to = params[:recipient]
    subject = "Arduino XMPP Test"
    body = "Wow, this is an Arduino XMPP Test message"
    m = Message::new(to, body).set_type(:normal).set_id("1").set_subject(subject)

    # Create the html part
    h = REXML::Element::new("html")
    h.add_namespace("http://jabber.org/protocol/xhtml-im")

    # The body part with the correct namespace
    b = REXML::Element::new("body")
    b.add_namespace("http://www.w3.org/1999/xhtml")

    # The html itself
    t = REXML::Text.new("MESSAGE: #{params[:message]} RECIPIENT: #{params[:recipient]}", false, nil, true, nil, %r/.^/)

    # Add the html text to the body, and the body to the html element
    b.add(t)
    h.add(b)

    # Add the html element to the message
    m.add_element(h)
    return m
  end
  
  def encode(obj)
  end
  
  def decode(obj)
  end
  
  def connect_to_xmpp
    DRb.start_service
    drb = DRbObject.new(nil, "druby://localhost:9435")
    status = drb.connect()
    if status
      device = Arduino.new
      device.device_id = request.headers["X-DeviceId"]
      device.drb = encode(drb)
      device.save
    end
    return status
  end

end
