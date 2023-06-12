require 'json'
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
				render json: {status:"found"}
			else
				render json: {status:"new"}
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
		if client.ipaddress != params[:ipaddress] or client.version != params[:version] or client.os != params[:os] or client.model != params[:model]
			client.update(ipaddress:  params[:ipaddress], version:  params[:version], os: params[:os], model: params[:model])
		end
	else 
		client = Wificlient.create(mac:params[:mac],os:params[:os],version:params[:version],serial:params[:serial],model:params[:model])
	end
	wlans = params[:wlans]
	wlans.each do |wlan|
		puts "WLAN: #{wlan[:mac]}"
		thiswlan = Wlan.find_by(mac:wlan['mac'])
		puts "WLAN BAND CHANNEL TEST: #{wlan["band1"]["channels"]}"
		wlang = wlan["band1"]["channels"]
		#wlana = wlan["band2"]["channels"]
		
		if thiswlan 
			thiswlan.update(lastseen: Time.new) 
			if thiswlan.wlan != wlan["wlan"] or thiswlan.phy != wlan["phy"] or thiswlan.txpower != wlan["txpower"] or thiswlan.g != wlan["band1"]["channels"] or thiswlan.a != wlan["band2"]["channels"]
				thiswlan.update(wlan: wlan["wlan"], phy: wlan["phy"], txpower: wlan["txpower"] , g: wlan["band1"]["channels"]) 
			end
		else 
			Wlan.create(mac: wlan["mac"],wlan:	wlan["wlan"],phy:wlan["phy"],txpower:wlan["txpower"],g:wlang, client_id: client.id, lastseen:Time.new, dateadded:Time.new)
		end
	end
end

