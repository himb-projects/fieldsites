json.extract! project, :id, :project_name, :project_details, :permit, :start_date, :end_date, :user_id, :created_at, :updated_at
json.url project_url(project, format: :json)
