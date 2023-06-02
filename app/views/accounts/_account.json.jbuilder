json.extract! account, :id, :first_name, :last_name, :email, :phone, :address1, :address2, :city, :state, :zip, :accounttype, :created_at, :updated_at
json.url account_url(account, format: :json)
