class CourseBatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_batch, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /course_batches or /course_batches.json
  def index
    @course_batches = CourseBatch.all
  end

  # GET /course_batches/1 or /course_batches/1.json
  def show
  end

  # GET /course_batches/new
  def new
    @course_batch = CourseBatch.new
  end

  # GET /course_batches/1/edit
  def edit
  end

  # POST /course_batches or /course_batches.json
  def create
    @course_batch = CourseBatch.new(course_batch_params)

    respond_to do |format|
      if @course_batch.save
        format.html { redirect_to course_batch_url(@course_batch), notice: "Course batch was successfully created." }
        format.json { render :show, status: :created, location: @course_batch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course_batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_batches/1 or /course_batches/1.json
  def update
    respond_to do |format|
      if @course_batch.update(course_batch_params)
        format.html { redirect_to course_batch_url(@course_batch), notice: "Course batch was successfully updated." }
        format.json { render :show, status: :ok, location: @course_batch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course_batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_batches/1 or /course_batches/1.json
  def destroy
    @course_batch.destroy

    respond_to do |format|
      format.html { redirect_to course_batches_url, notice: "Course batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def course_batch_params
    params.require(:course_batch).permit(:name, :max_enrollment_count, :start_date, :end_date, :course_id, :creator_id)
  end

  def set_course_batch
    @course_batch = CourseBatch.find(params[:id])
  end
end
