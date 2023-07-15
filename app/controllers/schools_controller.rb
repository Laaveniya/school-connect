# frozen_string_literal: true

class SchoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school, only: %i[show edit update destroy students]
  load_and_authorize_resource

  def students
    school = School.find(params[:id])
    students = school.students

    render json: students
  end

  # GET /schools or /schools.json
  def index
    @schools = School.all
  end

  # GET /schools/1 or /schools/1.json
  def show
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools or /schools.json
  def create
    @school = School.new(school_params.merge(creator: current_user))

    respond_to do |format|
      ActiveRecord::Base.transaction do
        if @school.save
          @school.adminships.create(user: current_user)
          format.html { redirect_to school_url(@school), notice: "School was successfully created." }
          format.json { render :show, status: :created, location: @school }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @school.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /schools/1 or /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to school_url(@school), notice: "School was successfully updated." }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1 or /schools/1.json
  def destroy
    @school.destroy

    respond_to do |format|
      format.html { redirect_to schools_url, notice: "School was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :address, :creator)
  end

  def set_school
    @school = School.find(params[:id])
  end
end
