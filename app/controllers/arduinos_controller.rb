class ArduinosController < ApplicationController

  before_filter :get_device

  # GET /arduinos
  # GET /arduinos.xml
  def index
    @arduinos = Arduino.find_all_by_user_id(current_user.id)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @arduinos }
    end
  end

  # GET /arduinos/1
  # GET /arduinos/1.xml
  def show
    not_your_device and return if @arduino.nil?
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @arduino }
    end
  end

  # GET /arduinos/new
  # GET /arduinos/new.xml
  def new
    @arduino = Arduino.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @arduino }
    end
  end

  # GET /arduinos/1/edit
  def edit
    not_your_device and return if @arduino.nil?
  end

  # POST /arduinos
  # POST /arduinos.xml
  def create
    @arduino = Arduino.new(params[:arduino])
    @arduino.user_id = current_user.id
    @arduino.device_key = Arduino.generate_device_key

    respond_to do |format|
      if @arduino.save
        flash[:notice] = "The device has been successfully created"
        format.html { redirect_to(@arduino) }
        format.xml  { render :xml => @arduino, :status => :created, :location => @arduino }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @arduino.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /arduinos/1
  # PUT /arduinos/1.xml
  def update
    not_your_device and return if @arduino.nil?

    respond_to do |format|
      if @arduino.update_attributes(params[:arduino])
        flash[:notice] = 'Arduino was successfully updated.'
        format.html { redirect_to(@arduino) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @arduino.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /arduinos/1
  # DELETE /arduinos/1.xml
  def destroy
    not_your_device and return if @arduino.nil?

    @arduino.destroy

    respond_to do |format|
      format.html { redirect_to(arduinos_url) }
      format.xml  { head :ok }
    end
  end

  private

  def get_device
    if params[:id] && current_user
      @arduino = Arduino.find_by_id_and_user_id(params[:id], current_user.id)
    else
      @arduino = nil
    end
  end

  def not_your_device
    flash[:error] = "Not your device"
    redirect_to :action => "index"
  end
end
