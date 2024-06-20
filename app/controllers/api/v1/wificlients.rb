require "digest"
require "json"
require "openssl"
require "base64"
include WlansHelper
module API
  module V1
    class Wificlients < Grape::API
      include API::V1::Defaults

      resource :wificlients do
        route :post, "hello" do
          process_hello(params)
          puts "Hello! This is the API"
          mac = params[:mac]
          puts "MAC address: #{mac}"
          client = Wificlient.find_by(mac: mac)
          if client
            render json: {status: "registered"}
          else
            render json: {status: "registered"}
          end
        end
        # desc "Return all wificlients"
        # get "", root: :wificlients do
        #   Wificlient.all
        # end
        # desc "Return a wificlient"
        #  params do
        #    requires :id, type: String, desc: "ID of the wificlient"
        #  end
        #  get ":id", root:"wificlient" do
        #    Wificlient.where(id: permitted_params[:id]).first!
        #  end
        route :post, "status" do
          mac = params[:mac]
          puts "MAC address: #{mac}"
          render json: {status: "success"}
        end

        route :post, "get_config" do
          process_config(params)

          # pmktest = genpmk('password', '123')
          # puts "TEST PMK!!!!! #{pmktest}"
        end

        route :post, "alive" do
          alive(params)
        end

        route :post, "update_wireless_clients" do
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
  client = Wificlient.find_by(mac: params[:mac])
  if client
    client.update(lastseen: Time.new)
    if client.ipaddress != params[:ipaddress] or client.version != params[:version] or client.os != params[:os] or client.model != params[:model]
      client.update(status: "Turned On", ipaddress: params[:ipaddress], version: params[:version], os: params[:os], model: params[:model])
    end
  else
    client = Wificlient.create(mac: params[:mac], status: "Turned On", os: params[:os], version: params[:version], serial: params[:serial], model: params[:model], lastseen: Time.new, dateadded: Time.new)
  end

  wlans = params[:wlans]
  a = []
  wlans.each do |wlan|
    thiswlan = Wlan.find_by(mac: wlan["mac"])
    a.push(wlan["mac"])
    wlang = wlan["band1"]["channels"]
    band2 = wlan["band2"]
    if thiswlan
      thiswlan.update(lastseen: Time.new)
      if !band2.nil?
        if thiswlan.wlan != wlan["wlan"] or thiswlan.phy != wlan["phy"] or thiswlan.txpower != wlan["txpower"] or thiswlan.g != wlan["band1"]["channels"] or thiswlan.a != wlan["band2"]["channels"] or thiswlan.client_id != client.id
          thiswlan.update(wlan: wlan["wlan"], phy: wlan["phy"], txpower: wlan["txpower"], g: wlan["band1"]["channels"], a: parseA(wlan["band2"]["channels"]), client_id: client.id)
        end
      elsif thiswlan.wlan != wlan["wlan"] or thiswlan.phy != wlan["phy"] or thiswlan.txpower != wlan["txpower"] or thiswlan.g != wlan["band1"]["channels"] or thiswlan.client_id != client.id
        thiswlan.update(wlan: wlan["wlan"], phy: wlan["phy"], txpower: wlan["txpower"], g: wlan["band1"]["channels"], client_id: client.id)
      end
    elsif !band2.nil?
      Wlan.create(mac: wlan["mac"], wlan: wlan["wlan"], phy: wlan["phy"], txpower: wlan["txpower"], g: wlan["band1"]["channels"], a: parseA(wlan["band2"]["channels"]), client_id: client.id, lastseen: Time.new, selected_g: wlan["band1"]["channels"], selected_a: parseA(wlan["band2"]["channels"]), dateadded: Time.new, name: wlan["wlan"], mode: "G", manager_id: client.manager_id)
    else
      Wlan.create(mac: wlan["mac"], wlan: wlan["wlan"], phy: wlan["phy"], txpower: wlan["txpower"], g: wlan["band1"]["channels"], client_id: client.id, lastseen: Time.new, selected_g: wlan["band1"]["channels"], dateadded: Time.new, name: wlan["wlan"], mode: "G", manager_id: client.manager_id)
    end

    Wlan.where(client_id: client.id).find_each do |wlan|
      puts "LOOOOKKKK A #{a}"
      if !a.include?(wlan.mac)
        wlan.update(client_id: nil, status: "Not present", channel: nil)
      end
    end
  end
end

def process_config(params)
  puts "PROCESSING CONFIG"
  client = Wificlient.find_by(mac: params[:mac])

  if client.enabled
    client.update(status: "Config")
    config_json = make_config(client)
  else
    config_json = {status: "OFF"}
    client.update(status: "Reg-Disabled")
    Wlan.where(client_id: client.id).find_each do |wlan|
      if !wlan.enabled
        wlan.update(status: "Con-Disabled")
      end
    end
  end

  # Generates a digest of the config using MD5.
  digest = Digest::MD5.hexdigest(config_json.to_s)

  # Adds the MD5 digest to the config.
  config_json[:configdigest] = digest

  # Updates the `configdigest` database entry for the given client.
  client.update(configdigest: digest)

  # the status of the wlans
  # client.update(pmk_change: false, config_change: false)
  puts "FINAL RESULT: #{config_json}"
  render json: config_json
end

def alive(params)
  client = Wificlient.find_by(mac: params[:mac])
  channels = params[:channels]

  # Gets the current config for the given client.
  config = make_config(client)

  # Computes the digest of the current config.
  config_digest = Digest::MD5.hexdigest(config.to_s)

  channels.each do |wlans|
    wlan = Wlan.where(client_id: client.id, wlan: wlans[0])
    wlan.update(channel: wlans[1])
  end
  wlanEnabled = false
  if !client.nil?
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

  if !client.nil? && client.enabled && wlanEnabled
    client.update(status: "Running")
  else
    client.update(status: "Error")
  end

  # Creates a digest to be rendered to JSON.
  alive_config = {"digest" => config_digest}
  alive_config[:action] = client.action

  # Actions only get sent to client once.
  # Question - should we wait for an confirmation from the client?
  if !client.action.nil? and !client.action.empty?
    puts "Clear action!"
    client.update(action: "")
  end

  render json: alive_config
end

# Creates and returns the current, server-specified configuration
# for the given client.
def make_config(client)
  # Initializes an empty hash to store the config.
  config = {}

  # An array of hashes that represent each pmk and user ID.
  puts "############################# #{client.name}"
  pmk = Wlan.where(client_id: client.id)
    .find_each
    .map { |wlan| wlan.zone }
    .flat_map do |zone_id|
      Userzone.where(zone_id: zone_id)
        .find_each
        .map { |uz| {pmk: uz.pmk, user_id: uz.user_id, maxdev: User.find(uz.user_id).maxdev, upmax: User.find(uz.user_id).upmax, downmax: User.find(uz.user_id).downmax } }
    end
  puts "%%%%%%%%%%%%%%%%%%%%%%%%% #{pmk}"
  # An array of hashes that represent a WLAN and its config.
  radios = Wlan.where(client_id: client.id)
    .find_each
    .map do |wlan|
      if wlan.enabled
        zone = Zone.find_by(id: wlan.zone)
        wlan_channels = (wlan.mode == "A") ? wlan.selected_a : wlan.selected_g
        hostapd_hash = {
          ssid: zone.ssid,
          interface: wlan.wlan,
          channel: JSON.parse(wlan_channels).first,
          hw_mode: wlan.mode,
          open: zone.open_ap,
          channel_list: wlan_channels
        }
        conf_hash = {mode: "AP", hostapd: hostapd_hash}
        {wlan: wlan.wlan, config: conf_hash}
      else
        {wlan: wlan.wlan, config: {mode: "OFF"}}
      end
    end

  # Adds the client's status, pmks, and radios to the config.
  config[:status] = client.enabled ? "success" : "OFF"
  config[:pmk] = pmk
  config[:radios] = radios

  # Returns the config hash (dictionary).
  config
end

$tx_dup = {}
def update_wireless_clients(params)
  ap_mac = params['AP']
  stations = params['Stations']

  stations.each do |station|
    station_params = station[1]
    mac = station[0]
     
    existing_record = StationLog.where(ap_mac: ap_mac, mac: mac.downcase, interface: station_params['interface']).order(updated_at: :desc).first
    if station_params['event'] != nil && station_params['event'] != 'assoc'
diss_record= StationLog.where(ap_mac: ap_mac, mac: mac.downcase).order(updated_at: :desc).first  
diss_record.update(associated: 'no', event: 'disassoc')
   
     
    elsif existing_record.nil?
      $tx_dup[mac.downcase.to_s]=station_params['tx bytes'].to_i
      new_record = StationLog.create(ap_mac: ap_mac, mac: mac.downcase, interface: station_params['interface'], channel: station_params['channel'],
                                     rx_bytes: station_params['rx bytes'], tx_bytes: 0, tx_retries: station_params['tx retries'],
                                     tx_failed: station_params['tx failed'], signal: station_params['signal'], signal_avg: station_params['signal avg'],
                                     tx_bitrate: station_params['tx bitrate'], rx_bitrate: station_params['rx bitrate'],
                                     expected_throughput: station_params['expected throughput'], associated: station_params['event'] == 'disassoc' ? 'no' : station_params['associated'],
                                     vid: station_params['vid'], ssid: station_params['ssid'], user_id: station_params['user_id'],
                                     event: station_params['associated'] == 'no' ? 'disassoc' : station_params['event'], connected_time: station_params['connected time'], current_time: station_params['current time'])
     
      if !station_params['user_id'].nil?
        new_record.update(manager_id: User.find_by(id: station_params['user_id']).manager_id)
      else
        new_record.update(manager_id: Wificlient.find_by(mac: ap_mac).manager_id)
      end
      elsif station_params['event'] != nil && station_params['event'] != 'assoc'
      existing_record.update(associated: 'no', event: 'disassoc')
    elsif
   if (existing_record.tx_bytes.to_i <= station_params['tx bytes'].to_i || existing_record.rx_bytes.to_i <= station_params['rx bytes'].to_i) && existing_record.connected_time.to_i < station_params['connected time'].to_i
              	puts "=*=*=* The station params is #{station_params['tx bytes']}"

        existing_record.update(rx_bytes: station_params['rx bytes'], tx_bytes: (station_params['tx bytes'].to_i - $tx_dup[mac.downcase.to_s].to_i),
                               tx_retries: station_params['tx retries'], tx_failed: station_params['tx failed'],
                               signal: station_params['signal'], signal_avg: station_params['signal avg'],
                               tx_bitrate: station_params['tx bitrate'], rx_bitrate: station_params['rx bitrate'],
                               expected_throughput: station_params['expected throughput'],
                               associated: station_params['event'] == 'disassoc' ? 'no' : station_params['associated'], vid: station_params['vid'], ssid: station_params['ssid'],
                               user_id: station_params['user_id'], event: station_params['associated'] == 'no' ? 'disassoc' : station_params['event'],
                               connected_time: station_params['connected time'], current_time: station_params['current time'])

        if !station_params['user_id'].nil?
          existing_record.update(manager_id: User.find_by(id: station_params['user_id']).manager_id)
        else
          existing_record.update(manager_id: Wificlient.find_by(mac: ap_mac).manager_id)
        end
      else
      	$tx_dup[mac.downcase.to_s]=station_params['tx bytes'].to_i
      	puts "=*=*=* The duplicate is #{$tx_dup[mac.downcase.to_s]}"
        new_record = StationLog.create(ap_mac: ap_mac, mac: mac.downcase, interface: station_params['interface'], channel: station_params['channel'],
                                       rx_bytes: station_params['rx bytes'], tx_bytes: 0, tx_retries: station_params['tx retries'],
                                       tx_failed: station_params['tx failed'], signal: station_params['signal'], signal_avg: station_params['signal avg'],
                                       tx_bitrate: station_params['tx bitrate'], rx_bitrate: station_params['rx bitrate'],
                                       expected_throughput: station_params['expected throughput'], associated: station_params['event'] == 'disassoc' ? 'no' : station_params['associated'],
                                       vid: station_params['vid'], ssid: station_params['ssid'], user_id: station_params['user_id'],
                                       event: station_params['associated'] == 'no' ? 'disassoc' : station_params['event'], connected_time: station_params['connected time'], current_time: station_params['current time'])

        if !station_params['user_id'].nil?
          new_record.update(manager_id: User.find_by(id: station_params['user_id']).manager_id)
        else
          new_record.update(manager_id: Wificlient.find_by(mac: ap_mac).manager_id)
        end
      end
    end
  end
end
