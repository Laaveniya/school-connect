module Admin
  class InvitationsController < ApplicationController
    layout 'center_left_layout'
    before_action :authenticate_user!
    before_action :check_admin_permissions

    def index
    end

    def new
      @user = User.new
    end

    def show
    end

    def create
      @user = User.invite!(invitation_params, current_user)
      school_id = params[:user][:school_id]

      if @user.errors.empty?
        if @user.role == "school_admin" && school_id.blank?
          @user.errors.add(:base, "School must be selected for School Admin role.")
          handle_invitation_failure(@user)
        elsif (@user.role == "school_admin" || @user.role == "student") && school_id.present? && !School.exists?(school_id)
          @user.errors.add(:base, "Invalid school selected.")
          handle_invitation_failure(@user)
        else
          handle_invitation_success(@user, school_id)
        end
      else
        handle_invitation_failure(@user)
      end
    end

    def handle_invitation_success(user, school_id)
      school = School.find(school_id) if school_id.present?
      if user.role == "school_admin"
        user.adminships.create!(school: school)
      elsif user.role == "student"
        user.school_memberships.create(user: user, school: school)
      end
      redirect_to new_admin_invitation_path, notice: "Invitation sent successfully."
    end

    def handle_invitation_failure(user)
      flash.now[:alert] = user.errors.full_messages.join(", ")
      redirect_to new_admin_invitation_path
    end

    private

    def invitation_params
      params.require(:user).permit(:email, :role)
    end

    def check_admin_permissions
      unless current_user.admin?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
      end
    end
  end
end
