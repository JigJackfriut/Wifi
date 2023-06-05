class WlanclientsController < ApplicationController
  before_action :set_wlanclient, only: %i[ show edit update destroy ]

  # GET /wlanclients or /wlanclients.json
  def index
    @wlanclients = Wlanclient.all
  end

  # GET /wlanclients/1 or /wlanclients/1.json
  def show
  end

  # GET /wlanclients/new
  def new
    @wlanclient = Wlanclient.new
  end

  # GET /wlanclients/1/edit
  def edit
  end

  # POST /wlanclients or /wlanclients.json
  def create
    @wlanclient = Wlanclient.new(wlanclient_params)

    respond_to do |format|
      if @wlanclient.save
        format.html { redirect_to wlanclient_url(@wlanclient), notice: "Wlanclient was successfully created." }
        format.json { render :show, status: :created, location: @wlanclient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wlanclient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wlanclients/1 or /wlanclients/1.json
  def update
    respond_to do |format|
      if @wlanclient.update(wlanclient_params)
        format.html { redirect_to wlanclient_url(@wlanclient), notice: "Wlanclient was successfully updated." }
        format.json { render :show, status: :ok, location: @wlanclient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wlanclient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wlanclients/1 or /wlanclients/1.json
  def destroy
    @wlanclient.destroy

    respond_to do |format|
      format.html { redirect_to wlanclients_url, notice: "Wlanclient was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wlanclient
      @wlanclient = Wlanclient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wlanclient_params
      params.require(:wlanclient).permit(:location, :ipaddress, :clientversion, :osversion, :hwmodel, :status, :pollrate, :lastseen, :note, :name, :dateadded, :confighash, :ownerid)
    end
end
