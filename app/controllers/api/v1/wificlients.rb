require 'json'
require 'openssl'
require 'base64'
include WlansHelper
module API
  module V1
    class Wificlients < Grape::API
      include API::V1::Defaults

      resource :wificlients do
		route :post, 'hello' do
			process_hello(params)
		    puts "Hello! This is the API"
		    mac = params[:mac]
			puts "MAC address: #{mac}"
			client = Wificlient.find_by(mac:mac)
			if client 
				render json: {status:"registered"}
			else
				render json: {status:"registered"}
			end
		end
       # desc "Return all wificlients"
       # get "", root: :wificlients do
       #   Wificlient.all
       # end
      #desc "Return a wificlient"
      #  params do
      #    requires :id, type: String, desc: "ID of the wificlient"
      #  end
      #  get ":id", root:"wificlient" do
      #    Wificlient.where(id: permitted_params[:id]).first!
      #  end
		route :post, 'status' do
			mac = params[:mac]
			puts "MAC address: #{mac}"
			render json: {status:"success"}
		end
		
		route :post, 'get_config' do 
			process_config(params)
			
			#pmktest = genpmk('password', '123')
			#puts "TEST PMK!!!!! #{pmktest}"
		end 
		
		route :post, 'alive' do 
			alive(params)
		end 
		
		route :post, 'update_wireless_clients' do 
			puts "HERE ARE PARAMS FOR WIRELESS, GO LOOK! #{params}"
			update_wireless_clients(params)
			
		end 
      
    end
    
	end 
  end
end

# Process Hello request
# 1. If MAC not in wificlients table, add to table, and add all radios to wlans table.
# 2. If MAC in wificlients table, Compare ipaddress, client version, osversion. If these have changes update.
# 3. For each radio, if it is not wlans table, add
# 4. For each radio, if in wlan table, update clientid if differnt
def process_hello(params) 
	client = Wificlient.find_by(mac:params[:mac]) 
	if client
		client.update(lastseen: Time.new)
		if client.ipaddress != params[:ipaddress] or client.version != params[:version] or client.os != params[:os] or client.model != params[:model]
			client.update(status: "Turned On", ipaddress:  params[:ipaddress], version:  params[:version], os: params[:os], model: params[:model])
		end
	else 
		client = Wificlient.create(mac:params[:mac], status: "Turned On", os:params[:os],version:params[:version],serial:params[:serial],model:params[:model], lastseen: Time.new, dateadded:Time.new, pmk_change: false, config_change: false)
	end
	
	wlans = params[:wlans] 
	a = Array.new
	wlans.each do |wlan|
		thiswlan = Wlan.find_by(mac:wlan['mac']) 
		a.push(wlan['mac'])
		wlang = wlan["band1"]["channels"]
		band2 = wlan["band2"]
		if thiswlan 
			thiswlan.update(lastseen: Time.new)
			if !band2.nil?
				if thiswlan.wlan != wlan["wlan"] or thiswlan.phy != wlan["phy"] or thiswlan.txpower != wlan["txpower"] or thiswlan.g != wlan["band1"]["channels"] or thiswlan.a != wlan["band2"]["channels"] or thiswlan.client_id != client.id
					thiswlan.update(wlan: wlan["wlan"],phy: wlan["phy"], txpower: wlan["txpower"] , g: wlan["band1"]["channels"], a: parseA(wlan["band2"]["channels"]), client_id: client.id) 
				end
			else 
				if thiswlan.wlan != wlan["wlan"] or thiswlan.phy != wlan["phy"] or thiswlan.txpower != wlan["txpower"] or thiswlan.g != wlan["band1"]["channels"] or thiswlan.client_id != client.id
					thiswlan.update(wlan: wlan["wlan"], phy: wlan["phy"], txpower: wlan["txpower"] , g: wlan["band1"]["channels"], client_id: client.id) 
				end
			end
		else 
			if !band2.nil?
				Wlan.create(mac: wlan["mac"],wlan:wlan["wlan"],phy:wlan["phy"],txpower:wlan["txpower"],g:wlan["band1"]["channels"], a:parseA(wlan["band2"]["channels"]),client_id: client.id, lastseen: Time.new, selected_g:wlan["band1"]["channels"], selected_a:parseA(wlan["band2"]["channels"]), dateadded:Time.new, name:wlan["wlan"], mode:"G", manager_id:client.manager_id)
			else 
				Wlan.create(mac: wlan["mac"],wlan:wlan["wlan"],phy:wlan["phy"],txpower:wlan["txpower"],g:wlan["band1"]["channels"],client_id: client.id, lastseen: Time.new, selected_g:wlan["band1"]["channels"],  dateadded:Time.new, name:wlan["wlan"], mode:"G", manager_id:client.manager_id)
			end
		end
		
		Wlan.where(:client_id => client.id).find_each do |wlan|
		puts "LOOOOKKKK A #{a}"
			if !a.include?(wlan.mac)
				wlan.update(client_id: nil, status: "Not present", channel: nil)
			end
		end
	end
end

def process_config(params)
	puts "PROCESSING CONFIG"
	client = Wificlient.find_by(mac:params[:mac])
	start = params[:start]
	zone_array = []
	radios = Array.new
	
	if client.enabled
		client.update(status: "Config")
		Wlan.where(client_id: client.id).find_each do |wlan|
			zone_array.append(wlan.zone)
			wlan_hash = {}
			zone = Zone.find_by(id: wlan.zone)
			if wlan.enabled
				hostapd_hash = {}
				if wlan.mode == "A"
					channels = wlan.selected_a
				else
					channels = wlan.selected_g
				end
				hostapd_hash.merge!({ "ssid": zone.ssid, "interface": wlan.wlan, "channel": JSON.parse(channels).first, "hw_mode": wlan.mode, "open": zone.open_ap, "channel_list": parseArray(channels) })
				conf_hash ={}
				conf_hash.merge!({ "mode": "AP", "hostapd": hostapd_hash})
				wlan_hash.merge!({ "wlan": wlan.wlan, "config": conf_hash})
			else 
				wlan_hash.merge!({ "wlan": wlan.wlan,"config":{ "mode": "OFF"}})
				wlan.update(status: "Con-Disabled", channel: nil)
			end
			radios.append(wlan_hash)
			
			if wlan.zone.nil?
				wlan.update(status: "Con-NoZone")		
			end
		end
	
		pmk = Array.new
		zone_array.each do |zoneID|
			Zone.find_by(id: zoneID)
			Userzone.where(zone_id: zoneID).find_each do |uz| 
				pmk_hash = {}
				pmk_hash.merge!({"pmk": uz.pmk, "user_id": uz.user_id})
				pmk.append(pmk_hash)
			end	
		end
	
		config_json = {"status": "success"}
		if (client.pmk_change && client.config_change) or (start == 1) or (!client.pmk_change && !client.config_change) 
			config_json.merge!({"status": "success", "pmk": pmk, "radios": radios})
		elsif client.pmk_change
			config_json.merge!({"status": "success", "pmk": pmk})
		elsif client.config_change
			config_json.merge!({"status": "success", "radios": radios})
		end
	else 
		config_json = {"status": "OFF"}
		client.update(status: "Reg-Disabled")
		Wlan.where(client_id: client.id).find_each do |wlan|
			if !wlan.enabled
				wlan.update(status: "Con-Disabled")
			end
		end
	end
	
	#the status of the wlans
	client.update(pmk_change: false, config_change: false)
	puts "FINAL RESULT: #{config_json}"
	render json: config_json
	
end


def alive(params)
	client = Wificlient.find_by(mac:params[:mac])
	channels = params[:channels]
	channels.each do |wlans|
		wlan = Wlan.where(client_id: client.id, wlan: wlans[0])
		wlan.update(channel: wlans[1])
	end
	wlanEnabled = false 	
	if client != nil
		Wlan.where(client_id: client.id).find_each do |wlan|
			if wlan.enabled	
				wlanEnabled = true
				wlan.update(status: "Run-Enabled")
			end
		end 
	 end
	 
	if !client.enabled 
	 	client.update(status: "Alive-Disabled") 
	 elsif client.lastseen <= 10.minutes.ago(Time.now)
	 	client.update(status: "No contact")
	 end
	
	if client != nil and (client.pmk_change or client.config_change) and client.enabled and wlanEnabled
		alive_config={"status" => "update"}
		client.update(status: "Running")
	elsif client != nil and (!client.pmk_change and !client.config_change) and client.enabled and wlanEnabled
		alive_config={"status" => "success"}
		client.update(status: "Running")
	else
		alive_config={"status" => "fail"}
		client.update(status: "Error")
	end
	render json: alive_config
	
end 


#Im changing the code here

=begin
def update_wireless_clients(params)
	apMac = params['AP']
	
	stations = params['Stations']
	stations.each do |station|
		stationParams = station[1]
		mac = station[0]
	 
		stationTest = StationLog.create(ap_mac: apMac, mac: mac.downcase, interface: stationParams['interface'],channel: stationParams['channel'], rx_bytes: stationParams['rx bytes'], tx_bytes: stationParams['tx bytes'], tx_retries: stationParams['tx retries'],tx_failed: stationParams['tx failed'], 
							signal: stationParams['signal'], signal_avg: stationParams['signal avg'], tx_bitrate: stationParams['tx bitrate'], rx_bitrate: stationParams['rx bitrate'], expected_throughput: stationParams['expected throughput'], associated: stationParams['associated'], vid: stationParams['vid'], ssid: stationParams['ssid'],
							user_id: stationParams['user_id'], event: stationParams['event'], connected_time: stationParams['connected time'])
		if !stationParams['user_id'].nil?
			stationTest.update(manager_id: User.find_by(id: stationParams['user_id']).manager_id)
		else
			stationTest.update(manager_id: Wificlient.find_by(mac: apMac).manager_id)
		end
	end
end


=end


def update_wireless_clients(params)
  ap_mac = params['AP']
  stations = params['Stations']

  stations.each do |station|
    station_params = station[1]
    mac = station[0]
    timestamp_seconds = station_params['connected time'].to_i / 1000
    timestamp_time = Time.at(timestamp_seconds)
    current_time = Time.now
    difference_in_seconds = (current_time - timestamp_time).to_i
    if difference_in_seconds < 180 && station_params['user_id'].present?
          stationTest.update(manager_id: User.find_by(id: station_params['user_id'])&.manager_id)
    else 
	   stationTest.destroy if stationTest.present? 
    end
    existing_record = StationLog.find_by(ap_mac: ap_mac, mac: mac.downcase, interface: station_params['interface'])

    if existing_record.nil?
      # Create a new record if no existing record found
      StationLog.create(ap_mac: ap_mac, mac: mac.downcase, interface: station_params['interface'], channel: station_params['channel'],
                        rx_bytes: station_params['rx bytes'], tx_bytes: station_params['tx bytes'], tx_retries: station_params['tx retries'],
                        tx_failed: station_params['tx failed'], signal: station_params['signal'], signal_avg: station_params['signal avg'],
                        tx_bitrate: station_params['tx bitrate'], rx_bitrate: station_params['rx bitrate'],
                        expected_throughput: station_params['expected throughput'], associated: station_params['associated'],
                        vid: station_params['vid'], ssid: station_params['ssid'], user_id: station_params['user_id'],
                        event: station_params['event'], connected_time: station_params['connected time'])
    else
      # Update existing record only if the new data has higher TX or RX bytes
      if existing_record.tx_bytes.to_i <= station_params['tx bytes'].to_i || existing_record.rx_bytes.to_i <= station_params['rx bytes'].to_i
        existing_record.update(rx_bytes: station_params['rx bytes'], tx_bytes: station_params['tx bytes'],
                               tx_retries: station_params['tx retries'], tx_failed: station_params['tx failed'],
                               signal: station_params['signal'], signal_avg: station_params['signal avg'],
                               tx_bitrate: station_params['tx bitrate'], rx_bitrate: station_params['rx bitrate'],
                               expected_throughput: station_params['expected throughput'],
                               associated: station_params['associated'], vid: station_params['vid'], ssid: station_params['ssid'],
                               user_id: station_params['user_id'], event: station_params['event'],
                               connected_time: station_params['connected time'])
      else
	            StationLog.create(ap_mac: ap_mac, mac: mac.downcase, interface: station_params['interface'], channel: station_params['channel'],
                        rx_bytes: station_params['rx bytes'], tx_bytes: station_params['tx bytes'], tx_retries: station_params['tx retries'],
                        tx_failed: station_params['tx failed'], signal: station_params['signal'], signal_avg: station_params['signal avg'],
                        tx_bitrate: station_params['tx bitrate'], rx_bitrate: station_params['rx bitrate'],
                        expected_throughput: station_params['expected throughput'], associated: station_params['associated'],
                        vid: station_params['vid'], ssid: station_params['ssid'], user_id: station_params['user_id'],
                        event: station_params['event'], connected_time: station_params['connected time'])
	      
      end
    end
    
  end
end

