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
			client.update(ipaddress:  params[:ipaddress], version:  params[:version], os: params[:os], model: params[:model])
		end
	else 
		client = Wificlient.create(mac:params[:mac],os:params[:os],version:params[:version],serial:params[:serial],model:params[:model], lastseen: Time.new, dateadded:Time.new, pmk_change: false, config_change: false)
	end
	
	wlans = params[:wlans] # we gat params from JSON
	a = Array.new
	w = Array.new
	wlans.each do |wlan|
		thiswlan = Wlan.find_by(mac:wlan['mac']) 
		a.push(wlan['mac'])
		wlang = wlan["band1"]["channels"]
		band2 = wlan["band2"]
		if thiswlan 
			thiswlan.update(lastseen: Time.new)
			if !band2.nil?
				if thiswlan.wlan != wlan["wlan"] or thiswlan.phy != wlan["phy"] or thiswlan.txpower != wlan["txpower"] or thiswlan.g != wlan["band1"]["channels"] or thiswlan.a != wlan["band2"]["channels"] or thiswlan.client_id != client.id
					thiswlan.update(wlan: wlan["wlan"], phy: wlan["phy"], txpower: wlan["txpower"] , g: wlan["band1"]["channels"], a: wlan["band2"]["channels"], client_id: client.id) 
				end
			else 
				if thiswlan.wlan != wlan["wlan"] or thiswlan.phy != wlan["phy"] or thiswlan.txpower != wlan["txpower"] or thiswlan.g != wlan["band1"]["channels"] or thiswlan.client_id != client.id
					thiswlan.update(wlan: wlan["wlan"], phy: wlan["phy"], txpower: wlan["txpower"] , g: wlan["band1"]["channels"], client_id: client.id) 
				end
			end
		else 
			if !band2.nil?
				Wlan.create(mac: wlan["mac"],wlan:wlan["wlan"],phy:wlan["phy"],txpower:wlan["txpower"],g:wlan["band1"]["channels"], a:wlan["band2"]["channels"],client_id: client.id, lastseen: Time.new, selected_g:wlan["band1"]["channels"], selected_a:wlan["band2"]["channels"], dateadded:Time.new, name:wlan["wlan"], mode:"G")
			else 
				Wlan.create(mac: wlan["mac"],wlan:wlan["wlan"],phy:wlan["phy"],txpower:wlan["txpower"],g:wlan["band1"]["channels"],client_id: client.id, lastseen: Time.new, selected_g:wlan["band1"]["channels"],  dateadded:Time.new, name:wlan["wlan"], mode:"G")
			end
		end
		
		Wlan.where(:client_id => client.id).find_each do |wlan|
			if !a.include?(wlan.mac)
				wlan.update(client_id: nil)
			end
			if !w.include?(wlan.id)
			w.push(wlan.id)
			end
		end
	client.update(wlan_name: w)
	end
end

def process_config(params)
	client = Wificlient.find_by(mac:params[:mac])
	start = params[:start]
	zone_array = [] 

	radios = Array.new
	#The Status of the Wificlient
	
	if client.enabled
		Wlan.where(client_id: client.id).find_each do |wlan|
			zone_array.append(wlan.zone)
			wlan_hash = {}
			zone = Zone.find_by(id: wlan.zone)
			puts "BEFORE WLAN"
			if wlan.enabled
				puts "BREAK IN SUCCESS"
				hostapd_hash = {}
				if wlan.mode == "A"
					channels = wlan.selected_a
				else
					channels = wlan.selected_g
				end
				hostapd_hash.merge!({ "ssid": zone.ssid, "interface": wlan.wlan, "channel": JSON.parse(channels).first, "hw_mode": wlan.mode, "open": zone.open_ap, "channel_list": parseArray(channels) })
				puts "HOSTAPD #{hostapd_hash}"
				conf_hash ={}
				conf_hash.merge!({ "mode": "AP", "hostapd": hostapd_hash})
				puts "CONF #{conf_hash}"
				wlan_hash.merge!({ "wlan": wlan.wlan, "config": conf_hash})
				puts "WLAN #{wlan_hash}"
			else 
				wlan_hash.merge!({ "wlan": wlan.wlan,"config":{ "mode": "OFF"}})
			end
			radios.append(wlan_hash)
		end
		puts "RADIOS #{radios}"
	
		pmk = Array.new
		zone_array.each do |zoneID|
			Zone.find_by(id: zoneID)
			Userzone.where(zone_id: zoneID).find_each do |uz| 
				pmk_hash = {}
				pmk_hash.merge!({ "pmk": uz.pmk, "user_id": uz.user_id})
				pmk.append(pmk_hash)
			end	
		end
		puts "PMK ARRAY: #{pmk}"
	
		config_json = {"status": "success"}
		if (client.pmk_change && client.config_change) or (start == 1) or (!client.pmk_change && !client.config_change) 
			config_json.merge!({"status": "success", "pmk": pmk, "radios": radios})
		elsif client.pmk_change
			config_json.merge!({"status": "OFF", "pmk": pmk})
		elsif client.config_change
			config_json.merge!({"status": "success", "radios": radios})
		end
	else 
		config_json = {"status": "OFF"}
	end
	
	#the status of the wlans
	
	puts "FINAL RESULT: #{config_json}"
	render json: config_json
end


def alive(params) 
	client = Wificlient.find_by(mac:params[:mac])
	 
	if client != nil and (client.pmk_change or client.config_change) and client.enabled
		alive_config={"status" => "update"}
	elsif client != nil and (!client.pmk_change and !client.config_change) and client.enabled
		alive_config={"status" => "success"}
	else
		alive_config={"status" => "fail"} 
	end
end 