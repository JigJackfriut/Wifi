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
	puts "Clients Changed!!!"
	if client
		if client.ipaddress != params[:ipaddress] or client.version != params[:version] or client.os != params[:os] or client.model != params[:model]
			client.update(ipaddress:  params[:ipaddress], version:  params[:version], os: params[:os], model: params[:model])
		end
	else 
		Wificlient.create(mac:params[:mac],os:params[:os],version:params[:version],serial:params[:serial],model:params[:model])
	end
	# Add or update wlans
	wlans = params[:wlans]
	wlans.each do |wlan|
		wlan = Wlan.find_by(mac:wlans[0]['mac'])
		if wlan 
			if wlan.wlan != wlans[0]["wlan"] or wlan.phy != wlans[0]["phy"] or wlan.txpower != wlans[0]["txpower"] or wlan.g != wlans[0]["g"] or wlan.a != wlans[0]["a"]
				wlan.update(wlan: wlans[0]["wlan"], phy: wlans[0]["phy"], txpower: wlans[0]["txpower"] , g: wlans[0]["g"], a: wlans[0]["a"])
			end
		else 
			Wlan.create( mac: wlans[0]["mac"],wlan:	wlans[0]["wlan"],phy:wlans[0]["phy"],txpower:wlans[0]["txpower"],g:wlans[0]["g"],a:wlans[0]["a"])
		end
	end
end
