class StationLogsController < ApplicationController
  before_action :set_station_log, only: %i[ show edit update destroy ]
  before_action :authenticate_manager!
  before_action :current_manager, only: [:edit, :update, :destroy]

  # GET /station_logs or /station_logs.json
  def index
    #@station_logs = StationLog.all
	stationList_array = StationLog.find_by_sql('select * from station_logs t inner join ( select mac, max(created_at) as MaxDate from station_logs where user_id IS NOT NULL group by mac ) tm on t.mac = tm.mac and t.created_at = tm.MaxDate;')	
	stationList = StationLog.where(id: stationList_array.map(&:id))
	sort_order_username = cookies[:sort_order_username] || 'asc' 
	sort_order_rx_bytes = cookies[:sort_order_rx_bytes] || 'asc' 

    if params[:sort] == "Username"
      @station_logs = stationList.sort_by{|station_log| User.find_by(id: station_log.user_id).name}
	elsif params[:sort] == "rx_bytes"
	  	if sort_order_rx_bytes == 'desc'
			@station_logs = stationList.sort_by{|station_log| station_log.rx_bytes.to_i}.reverse
		elsif sort_order_rx_bytes == 'asc'
			@station_logs = stationList.sort_by{|station_log| station_log.rx_bytes.to_i}
		end 
	puts "sort attempted" 
    else
      @station_logs = stationList
	  puts "else triggered, oops?"
    end
	cookies[:sort_order_username] = sort_order_username == 'asc' ? 'desc' : 'asc'
	cookies[:sort_order_rx_bytes] = sort_order_rx_bytes == 'asc' ? 'desc' : 'asc'
	
	#puts "LOOKKK AT THE STATION LOGGS #{@station_logs.pluck(:id)}" # [380, 407, 522, 606, 401, 602, 601]
	#arr = @station_logs.pluck(:id)
	#puts "LOOKKK INSIDEE THE STATION LOGGS #{arr.map { |x| x.id }}" 
	#@stat_logs = stationList.where(id: arr.map(&:id))
	#@pagy, @station_logs = pagy(@station_logs)
	#@station_logs = stationList.where(id: @station_logs.pluck(:id))
#	Model.where(id: results.pluck(:id))

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

  def correct_manager
  	@station_log = current_manager.station_logs.find_by(id: params[:id])
  	redirect_to station_logs_path, notice: "Not Authorized To Edit This StationLog" if @station_log.nil?
  end
  
  
  # POST /station_logs or /station_logs.json
  def create
    #@station_log = StationLog.new(station_log_params)
	@station_log = current_manager.station_logs.build(station_log_params)


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
