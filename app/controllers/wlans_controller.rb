class WlansController < ApplicationController
  include WlansHelper
  before_action :set_wlan, only: %i[ show edit update destroy ]
  before_action :authenticate_manager!  # GET /wlans or /wlans.json
  before_action :current_manager, only: [:edit, :update, :destroy]
  def index
    @wlans = Wlan.all
  end

  # GET /wlans/1 or /wlans/1.json
  def show
  end

  # GET /wlans/new
  def new
    #@wlan = Wlan.new
    @wlan = current_manager.wlans.build
  end

  # GET /wlans/1/edit
  def edit
  end
  
  def correct_manager
  	@wlan = current_manager.wlans.find_by(id: params[:id])
  	redirect_to wlans_path, notice: "Not Authorized To Edit This WLAN" if @wlan.nil?
  end

  # POST /wlans or /wlans.json
  def create
    #@wlan = Wlan.new(wlan_params)
	@wlan = current_manager.wlans.build(wlan_params)
    respond_to do |format|
      if @wlan.save
        format.html { redirect_to wlan_url(@wlan), notice: "Wlan was successfully created." }
        format.json { render :show, status: :created, location: @wlan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wlan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wlans/1 or /wlans/1.json
  def update

	wlanUpdate(@wlan, wlan_params)
	
    respond_to do |format|
      if @wlan.update(wlan_params)
        format.html { redirect_to wlan_url(@wlan), notice: "Wlan was successfully updated." }
        format.json { render :show, status: :ok, location: @wlan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wlan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wlans/1 or /wlans/1.json
  def destroy
	client = Wificlient.find_by(id: @wlan.client_id)
	if client
		client.update(config_change: true)
		puts "client ID! : #{client.id}"
	end 
	
    @wlan.destroy

    respond_to do |format|
      format.html { redirect_to wlans_url, notice: "Wlan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wlan
      @wlan = Wlan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wlan_params
      params.require(:wlan).permit(:mac, :name, :description, :status, :wlan, :phy, :txpower, :a, :g, :lastseen, :dateadded, [:selected_a => []], [:selected_g => []], :channel, :client_id, :manager_id, :enabled, :client_name, :zone, :mode)
    end
end
