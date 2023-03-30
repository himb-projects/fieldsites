json.extract! site, :id, :site_name, :latitude, :longitude, :shared, :project_id, :created_at, :updated_at
json.url site_url(site, format: :json)
