class WificlientsController < ApplicationController
  before_action :set_wificlient, only: %i[ show edit update destroy ]
  # GET /wificlients or /wificlients.json
  def index
    @wificlients = Wificlient.all
  end

  # GET /wificlients/1 or /wificlients/1.json
  def show
  end

  # GET /wificlients/new
  def new
    @wificlient = Wificlient.new
  end

  # GET /wificlients/1/edit
  def edit
  end

  # POST /wificlients or /wificlients.json
  def create
    @wificlient = Wificlient.new(wificlient_params)

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
    @wificlient.destroy

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
      params.require(:wificlient).permit(:location, :ipaddress, :clientversion, :osversion, :hwmodel, :status, :pollrate, :lastseen, :note, :name, :dateadded, :confighash, :ownerid, :enabled)
    end
	
	
end
