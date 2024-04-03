require 'will_paginate/array'
class StationLogsController < ApplicationController
  before_action :set_station_log, only: %i[ show edit update destroy ]
  before_action :authenticate_manager!
  before_action :current_manager, only: [:edit, :update, :destroy]

  # GET /station_logs or /station_logs.json
  def index
    #@station_logs = StationLog.all
	puts "NEW SORT ATTEMPTED WEE WOO WEE WOO ENTERING INDEX"
	managerID = current_manager.id.to_s 
	stationList = StationLog.find_by_sql('select * from station_logs t inner join ( select mac, max(created_at) as MaxDate from station_logs where user_id IS NOT NULL group by mac ) tm on t.mac = tm.mac and t.created_at = tm.MaxDate and t.manager_id = '+ managerID+ ' and t.created_at > DATE_SUB(NOW(), INTERVAL 10 MINUTE)')
	
	#stationList = StationLog.where(id: stationList_array.map(&:id))
	#puts "sort username!: #{sort_order_username}"
	
	#puts "sort rx_bytes!: #{sort_order_rx_bytes}"
	
    if params[:sort] == "Username_asc"
	  sort_order_username = cookies[:sort_order_username] || 'asc' 
	  if sort_order_username == 'asc'
			cookies[:sort_order_username] = sort_order_username == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| User.find_by(id: station_log.user_id).name}
	elsif params[:sort] == "Username_desc"
	  sort_order_username = cookies[:sort_order_username] || 'asc' 
	  if sort_order_username == 'desc'
			cookies[:sort_order_username] = sort_order_username == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| User.find_by(id: station_log.user_id).name}.reverse
	  
	elsif params[:sort] == "Rx_bytes_asc"
		sort_order_rx_bytes = cookies[:sort_order_rx_bytes] || 'asc' 
	  	if sort_order_rx_bytes == 'asc'
	  		cookies[:sort_order_rx_bytes] = sort_order_rx_bytes == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.rx_bytes.to_i}
	elsif params[:sort] == "Rx_bytes_desc"
		sort_order_rx_bytes = cookies[:sort_order_rx_bytes] || 'asc' 
	  	if sort_order_rx_bytes == 'desc'
	  		cookies[:sort_order_rx_bytes] = sort_order_rx_bytes == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.rx_bytes.to_i}.reverse
	
	elsif params[:sort] == "Tx_bytes_asc"
		sort_order_tx_bytes = cookies[:sort_order_tx_bytes] || 'asc' 
	  	if sort_order_tx_bytes == 'asc'
	  		cookies[:sort_order_tx_bytes] = sort_order_tx_bytes == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.tx_bytes.to_i}
	elsif params[:sort] == "Tx_bytes_desc"
		sort_order_tx_bytes = cookies[:sort_order_tx_bytes] || 'asc' 
	  	if sort_order_tx_bytes == 'desc'
	  		cookies[:sort_order_tx_bytes] = sort_order_tx_bytes == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.tx_bytes.to_i}.reverse
	
	
	elsif params[:sort] == "Signal_asc"
		sort_order_signal = cookies[:sort_order_signal] || 'asc' 
	  	if sort_order_signal == 'asc'
	  		cookies[:sort_order_signal] = sort_order_signal == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.signal.to_i}
	elsif params[:sort] == "Signal_desc"
		sort_order_signal = cookies[:sort_order_signal] || 'asc' 
	  	if sort_order_signal == 'desc'
	  		cookies[:sort_order_signal] = sort_order_signal == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.signal.to_i}.reverse
		
	elsif params[:sort] == "Tx_failed_asc"
		sort_order_tx_failed = cookies[:sort_order_tx_failed] || 'asc' 
	  	if sort_order_tx_failed == 'asc'
	  		cookies[:sort_order_tx_failed] = sort_order_tx_failed == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.tx_failed.to_i}
	elsif params[:sort] == "Tx_failed_desc"
		sort_order_tx_failed = cookies[:sort_order_tx_failed] || 'asc' 
	  	if sort_order_tx_failed == 'desc'
	  		cookies[:sort_order_tx_failed] = sort_order_tx_failed == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.tx_failed.to_i}.reverse
		
	elsif params[:sort] == "T_connected_asc"
		sort_order_t_connected = cookies[:sort_order_t_connected] || 'asc' 
	  	if sort_order_t_connected == 'asc'
	  		cookies[:sort_order_t_connected] = sort_order_t_connected == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.connected_time.to_i}
	elsif params[:sort] == "T_connected_desc"
		sort_order_t_connected = cookies[:sort_order_t_connected] || 'asc' 
	  	if sort_order_t_connected == 'desc'
	  		cookies[:sort_order_t_connected] = sort_order_t_connected == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.connected_time.to_i}.reverse
		
	elsif params[:sort] == "T_connected_asc"
		sort_order_t_connected = cookies[:sort_order_t_connected] || 'asc' 
	  	if sort_order_t_connected == 'asc'
	  		cookies[:sort_order_t_connected] = sort_order_t_connected == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.connected_time.to_i}
	elsif params[:sort] == "T_connected_desc"
		sort_order_t_connected = cookies[:sort_order_t_connected] || 'asc' 
	  	if sort_order_t_connected == 'desc'
	  		cookies[:sort_order_t_connected] = sort_order_t_connected == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.connected_time.to_i}.reverse
	
	elsif params[:sort] == "Connected_at_asc"
		sort_order_connected_at = cookies[:sort_order_connected_at] || 'asc' 
	  	if sort_order_connected_at == 'asc'
	  		cookies[:sort_order_connected_at] = sort_order_connected_at == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.created_at.to_i}
	elsif params[:sort] == "Connected_at_desc"
		sort_order_connected_at = cookies[:sort_order_connected_at] || 'asc' 
	  	if sort_order_connected_at == 'desc'
	  		cookies[:sort_order_connected_at] = sort_order_connected_at == 'asc' ? 'desc' : 'asc'
		end
		@station_logs = stationList.sort_by{|station_log| station_log.created_at.to_i}.reverse
		
		sort_order_connected_at
		
	elsif params[:sort] == "Ssid_asc"
	  sort_order_ssid = cookies[:sort_order_ssid] || 'asc' 
	  if sort_order_ssid== 'asc'
			cookies[:sort_order_ssid] = sort_order_ssid == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.ssid}
	elsif params[:sort] == "Ssid_desc"
	  sort_order_ssid = cookies[:sort_order_ssid] || 'asc' 
	  if sort_order_ssid == 'desc'
			cookies[:sort_order_ssid] = sort_order_ssid == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.ssid}.reverse
	
	elsif params[:sort] == "Station_mac_asc"
	  sort_order_station_mac = cookies[:sort_order_station_mac] || 'asc' 
	  if sort_order_station_mac == 'asc'
			cookies[:sort_order_station_mac] = sort_order_station_mac == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.mac}
	elsif params[:sort] == "Station_mac_desc"
	  sort_order_station_mac = cookies[:sort_order_station_mac] || 'asc' 
	  if sort_order_station_mac == 'desc'
			cookies[:sort_order_station_mac] = sort_order_station_mac == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.mac}.reverse
    
	elsif params[:sort] == "Ap_asc"
	  sort_order_ap = cookies[:sort_order_ap] || 'asc' 
	  if sort_order_ap == 'asc'
			cookies[:sort_order_ap] = sort_order_ap == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.ap_mac}
	elsif params[:sort] == "Ap_desc"
	  sort_order_ap = cookies[:sort_order_ap] || 'asc' 
	  if sort_order_ap == 'desc'
			cookies[:sort_order_ap] = sort_order_ap == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.ap_mac}.reverse
	
	 elsif params[:sort] == "Wlan_asc"
	  sort_order_wlan = cookies[:sort_order_wlan] || 'asc' 
	  if sort_order_wlan == 'asc'
			cookies[:sort_order_wlan] = sort_order_wlan == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.ap_mac}.sort_by{|station_log| station_log.interface}
	elsif params[:sort] == "Wlan_desc"
	  sort_order_wlan = cookies[:sort_order_wlan] || 'asc' 
	  if sort_order_wlan == 'desc'
			cookies[:sort_order_wlan] = sort_order_wlan == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.interface}.sort_by{|station_log| station_log.ap_mac}.reverse

	elsif params[:sort] == "Channel_asc"
	  sort_order_channel = cookies[:sort_order_channel] || 'asc' 
	  if sort_order_channel == 'asc'
			cookies[:sort_order_channel] = sort_order_channel == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.channel}
	elsif params[:sort] == "Channel_desc"
	  sort_order_channel = cookies[:sort_order_channel] || 'asc' 
	  if sort_order_channel == 'desc'
			cookies[:sort_order_channel] = sort_order_channel == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.channel}.reverse
	
	elsif params[:sort] == "Vlan_asc"
	  sort_order_vlan = cookies[:sort_order_vlan] || 'asc' 
	  if sort_order_vlan == 'asc'
			cookies[:sort_order_vlan] = sort_order_vlan == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.vid}
	elsif params[:sort] == "Vlan_desc"
	  sort_order_vlan = cookies[:sort_order_vlan] || 'asc' 
	  if sort_order_vlan == 'desc'
			cookies[:sort_order_vlan] = sort_order_vlan == 'asc' ? 'desc' : 'asc'
	  end
	  @station_logs = stationList.sort_by{|station_log| station_log.vid}.reverse
	else
      @station_logs = stationList
    end


	@station_logs = @station_logs.paginate(:page => params[:page], :per_page => 30)
	
	
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
