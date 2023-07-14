json.extract! course_batch, :id, :name, :max_enrollment_count, :course_id, :start_date, :end_date, :created_at, :updated_at
json.url course_batch_url(course_batch, format: :json)
