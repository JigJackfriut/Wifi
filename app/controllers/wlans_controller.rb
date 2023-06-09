class WlansController < ApplicationController
  before_action :set_wlan, only: %i[ show edit update destroy ]
	before_action :authenticate_user!, except: [:index, :show] #if your are not logged 
	#in you can see friends and list but can't do anything else.
  # GET /wlans or /wlans.json
  def index
    @wlans = Wlan.all
  end

  # GET /wlans/1 or /wlans/1.json
  def show
  end

  # GET /wlans/new
  def new
    #@wlan = Wlan.new
    @wlan = current_user.wlans.build
  end

  # GET /wlans/1/edit
  def edit
  end

  # POST /wlans or /wlans.json
  def create
    #@wlan = Wlan.new(wlan_params)
	@wlan = current_user.wlans.build(wlan_params)
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
      params.require(:wlan).permit(:mac, :name, :description, :status, :wlan, :phy, :txpower, :a, :g, :lastseen, :dateadded, :autochannel, :channel, :client_id)
    end
end
