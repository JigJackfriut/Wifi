class UserzonesController < ApplicationController
  before_action :set_userzone, only: %i[ show edit update destroy ]

  # GET /userzones or /userzones.json
  def index
    @userzones = Userzone.all
  end

  # GET /userzones/1 or /userzones/1.json
  def show
  end

  # GET /userzones/new
  def new
    @userzone = Userzone.new
  end

  # GET /userzones/1/edit
  def edit
  end

  # POST /userzones or /userzones.json
  def create
    @userzone = Userzone.new(userzone_params)

    respond_to do |format|
      if @userzone.save
        format.html { redirect_to userzone_url(@userzone), notice: "Userzone was successfully created." }
        format.json { render :show, status: :created, location: @userzone }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @userzone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /userzones/1 or /userzones/1.json
  def update
    respond_to do |format|
      if @userzone.update(userzone_params)
        format.html { redirect_to userzone_url(@userzone), notice: "Userzone was successfully updated." }
        format.json { render :show, status: :ok, location: @userzone }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @userzone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userzones/1 or /userzones/1.json
  def destroy
    @userzone.destroy

    respond_to do |format|
      format.html { redirect_to userzones_url, notice: "Userzone was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userzone
      @userzone = Userzone.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def userzone_params
      params.require(:userzone).permit(:zone_id, :user_id, :pmk)
    end
end
