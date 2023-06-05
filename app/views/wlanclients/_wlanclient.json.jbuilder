json.extract! wlanclient, :id, :location, :ipaddress, :clientversion, :osversion, :hwmodel, :status, :pollrate, :lastseen, :note, :name, :dateadded, :confighash, :ownerid, :created_at, :updated_at
json.url wlanclient_url(wlanclient, format: :json)
