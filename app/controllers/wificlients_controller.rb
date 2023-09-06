class WificlientsController < ApplicationController
	include WificlientsHelper
	after_action :set_defaults

  before_action :set_wificlient, only: %i[ show edit update destroy ]
  before_action :authenticate_manager!
  before_action :current_manager, only: [:edit, :update, :destroy]
  # GET /wificlients or /wificlients.json
  def index
    @wificlients = Wificlient.all
  end

  # GET /wificlients/1 or /wificlients/1.json
  def show
  end

  # GET /wificlients/new
  def new
    #@wificlient = Wificlient.new
    @wificlient = current_manager.wificlients.build
  end

  # GET /wificlients/1/edit
  def edit
  end
  
  def correct_manager
  	@wificlient = current_manager.wificlients.find_by(id: params[:id])
  	redirect_to wificlients_path, notice: "Not Authorized To Edit This Wificlient" if @wificlient.nil?
  end

  # POST /wificlients or /wificlients.json
  def create
	client = Wificlient.find_by(mac:wificlient_params[:mac]) #check that we client in the database
	check = false
	if client && client.manager_id.nil? # checking if there is a client and manager is nil for whether its is 
		check = true
	end

	unique = false
	if !Wificlient.find_by(name:wificlient_params[:name]) && check
		unique = true
		client.update(name: wificlient_params[:name])
		client.update(manager_id: current_manager.id)
		Wlan.where(:client_id => client.id).find_each do |wlan|
			wlan.update(manager_id: current_manager.id, client_name:client.name)
		end
	end 

    respond_to do |format|
		if !client.nil? && client.save && check && unique
        	format.html { redirect_to wificlient_url(client), notice: "Wificlient was successfully created." }
        	format.json { render :show, status: :created, location: client }
 		elsif !client.nil? && client.save && !check
			format.html { redirect_to wificlients_url, alert: "Error: Wificlient already assigned" }
 		elsif client.nil?
			format.html { redirect_to wificlients_url, alert: "Error: Wificlient is not registered" }
		elsif !unique
			format.html { redirect_to wificlients_url, alert: "Error: Name is already taken" }
      	else
        	format.html { render :new, status: :unprocessable_entity }
        	format.json { render json: @wificlient.errors, status: :unprocessable_entity }
      	end
	end
  end

  # PATCH/PUT /wificlients/1 or /wificlients/1.json
  def update
	wificlientUpdate(@wificlient, wificlient_params)
    respond_to do |format|
      if @wificlient.update(wificlient_params)
        format.html { redirect_to wificlient_url(@wificlient), notice: "Wificlient was successfully updated." }
        format.json { render :show, status: :ok, location: @wificlient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wificlient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wificlients/1 or /wificlients/1.json
  def destroy
	#grab client_id prior to deleting 
	idReset = @wificlient.id 
    @wificlient.destroy
	
	#set associated wlans to null  
	Wlan.where( :client_id => idReset).find_each do |wlan|
		wlan.update(client_id: nil) 
	end
		
    respond_to do |format|
      format.html { redirect_to wificlients_url, notice: "Wificlient was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wificlient
      print "SKON\n"
      @wificlient = Wificlient.find(params[:id])
    end
    def set_defaults
    	status = "Turned Off"
  	end

    # Only allow a list of trusted parameters through.
    def wificlient_params
      params.require(:wificlient).permit(:mac, :location, :ipaddress, :version, :os, :model, :status, :pollrate, :lastseen, :note, :name, :dateadded, :confighash, :manager_id, :enabled, :wlan_name, :update_needed)
    end
	
end
