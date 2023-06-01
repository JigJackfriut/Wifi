json.extract! owner, :id, :first_name, :last_name, :email, :phone, :address1, :address2, :city, :state, :zip, :ownertype, :created_at, :updated_at
json.url owner_url(owner, format: :json)
