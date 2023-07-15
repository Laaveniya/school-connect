class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]
  # GET /users or /users.json
  def index
    session[:requested_url] = request.original_url
    @q = params[:q]
    if current_user.school_admin?
      @users = if @q.present?
                 User.search(@q, where: { id: current_user.administered_students.pluck(:id) })
               else
                 current_user.administered_students
               end
    else
      @users = search_results(@q)
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    accessible = [
      :name,
      :email,
      :role,
      :password,
      :password_confirmation
    ]
    params.require(:user).permit(accessible)
  end

  def search_results(query)
    query.present? ? User.search(query) : User.all
  end
end
