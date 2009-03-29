class ArduinosController < ApplicationController
  # GET /arduinos
  # GET /arduinos.xml
  def index
    @arduinos = Arduino.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @arduinos }
    end
  end

  # GET /arduinos/1
  # GET /arduinos/1.xml
  def show
    @arduino = Arduino.find(params[:id])

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
    @arduino = Arduino.find(params[:id])
  end

  # POST /arduinos
  # POST /arduinos.xml
  def create
    @arduino = Arduino.new(params[:arduino])

    respond_to do |format|
      if @arduino.save
        flash[:notice] = 'Arduino was successfully created.'
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
    @arduino = Arduino.find(params[:id])

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
    @arduino = Arduino.find(params[:id])
    @arduino.destroy

    respond_to do |format|
      format.html { redirect_to(arduinos_url) }
      format.xml  { head :ok }
    end
  end
end
