json.extract! user, :id, :first, :last, :email, :phone, :address1, :address2, :city, :state, :zip, :type, :created_at, :updated_at
json.url user_url(user, format: :json)
