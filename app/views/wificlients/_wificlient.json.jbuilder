json.extract! wificlient, :id, :location, :ipaddress, :clientversion, :osversion, :hwmodel, :status, :pollrate, :lastseen, :note, :name, :dateadded, :confighash, :ownerid, :enabled, :created_at, :updated_at
json.url wificlient_url(wificlient, format: :json)
