class WificlientsController < ApplicationController
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
  
  def currect_manager
  	@wificlient = current_manager.wificlients.find_by(id: params[:id])
  	redirect_to friends_path, notice: "Not Authorized To Edit This Friend" if @wificlient.nil?
  end

  # POST /wificlients or /wificlients.json
  def create
    #@wificlient = Wificlient.new(wificlient_params)
	@wificlient = current_manager.wificlients.build(wificlient_params)
	
    respond_to do |format|
      if @wificlient.save
        format.html { redirect_to wificlient_url(@wificlient), notice: "Wificlient was successfully created." }
        format.json { render :show, status: :created, location: @wificlient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wificlient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wificlients/1 or /wificlients/1.json
  def update
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
	Wlan.find_each do |wlan|
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
      @wificlient = Wificlient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wificlient_params
      params.require(:wificlient).permit(:location, :ipaddress, :version, :os, :model, :status, :pollrate, :lastseen, :note, :name, :dateadded, :confighash, :manager_id, :enabled)
    end
	
	
end
