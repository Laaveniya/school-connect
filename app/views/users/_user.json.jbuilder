json.extract! user, :id, :role, :email, :password, :name, :created_at, :updated_at
json.url user_url(user, format: :json)
