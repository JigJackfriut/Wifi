json.extract! user, :id, :name, :type, :passphrase, :manager_id, :zone, :created_at, :updated_at
json.url user_url(user, format: :json)
