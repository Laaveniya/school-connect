# frozen_string_literal = true

class Enrollment < ApplicationRecord
  belongs_to :course_batch
  belongs_to :student, class_name: 'User', foreign_key: :student_id
  belongs_to :approver, class_name: 'User', foreign_key: :approver_id, optional: true

  enum status: { requested: 0, approved: 1, dropped: 2, denied: 3 }

  scope :for_schools_administered_by, ->(user) { joins(course_batch: :course).where(courses: { school: user.schools_administered }) }
end
