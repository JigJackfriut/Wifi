class StationLogsController < ApplicationController
  before_action :set_station_log, only: %i[ show edit update destroy ]

  # GET /station_logs or /station_logs.json
  def index
    @station_logs = StationLog.all
  end

  # GET /station_logs/1 or /station_logs/1.json
  def show
  end

  # GET /station_logs/new
  def new
    @station_log = StationLog.new
  end

  # GET /station_logs/1/edit
  def edit
  end

  # POST /station_logs or /station_logs.json
  def create
    @station_log = StationLog.new(station_log_params)

    respond_to do |format|
      if @station_log.save
        format.html { redirect_to station_log_url(@station_log), notice: "Station log was successfully created." }
        format.json { render :show, status: :created, location: @station_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @station_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /station_logs/1 or /station_logs/1.json
  def update
    respond_to do |format|
      if @station_log.update(station_log_params)
        format.html { redirect_to station_log_url(@station_log), notice: "Station log was successfully updated." }
        format.json { render :show, status: :ok, location: @station_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @station_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /station_logs/1 or /station_logs/1.json
  def destroy
    @station_log.destroy

    respond_to do |format|
      format.html { redirect_to station_logs_url, notice: "Station log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station_log
      @station_log = StationLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def station_log_params
      params.require(:station_log).permit(:AP, :station, :interface, :channel, :rx_bytes, :tx_bytes, :tx_retries, :tx_failed, :signal, :signal_avg, :tx_bitrate, :rx_bitrate, :expected_throughput, :associated, :vid, :ssid, :user_id, :event, :mac)
    end
end
