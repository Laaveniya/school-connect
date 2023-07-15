class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enrollment, only: %i[ show edit update destroy ]
  load_and_authorize_resource except: :new

  # GET /enrollments or /enrollments.json
  def index
    @enrollments =
      if current_user.school_admin?
        Enrollment.for_schools_administered_by(current_user)
      else
        Enrollment.all
      end
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
    if current_user.school_admin?
      @schools = current_user.schools_administered
    end
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments or /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)
    respond_to do |format|
      if @enrollment.save
        if current_user.student?
          redirect_to back_url, notice: "Enrollment was successfully created."
        else
          format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully created." }
          format.json { render :show, status: :created, location: @enrollment }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    @enrollment.destroy

    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def enrollment_params
    params.require(:enrollment).permit(:course_batch_id, :student_id, :status, :approver_id)
  end

  def back_url
    request.referer
  end
end
