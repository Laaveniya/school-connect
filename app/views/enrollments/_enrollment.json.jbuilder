json.extract! enrollment, :id, :course_batch_id, :student_id, :status, :approver_id, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
