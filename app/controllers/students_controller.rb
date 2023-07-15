class StudentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: 'User'

  def dashboard
    @student = current_user
    @course_batches = current_user.school.course_batches
    @classmates = @student.classmates
    @enrollments = @student.enrollments

    render :dashboard
  end

  def enroll_course_batch
    course_batch_id = params[:course_batch_id]
    enrollment = Enrollment.new(student_id: current_user.id, course_batch_id: course_batch_id, status: :requested, approver_id: nil)

    if enrollment.save

      redirect_to dashboard_path, notice: "Successfully enrolled in course."
    else
      render :new, status: :unprocessable_entity
    end
  end
end
