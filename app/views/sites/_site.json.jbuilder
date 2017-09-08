json.extract! site, :id, :user_id, :name, :caption, :release_status, :created_at, :updated_at
json.url site_url(site, format: :json)
