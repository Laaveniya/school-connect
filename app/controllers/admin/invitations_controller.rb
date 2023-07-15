module Admin
  class InvitationsController < Devise::InvitationsController
    layout 'center_left_layout'
    before_action :authenticate_user!
    before_action :check_admin_permissions, only: :create

    def index
    end

    def new
      @user = User.new
      @schools =
        if current_user.admin?
          School.all
        elsif current_user.school_admin?
          current_user.schools_administered
        end

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
      if user.school_admin? || user.admin?
        user.adminships.create!(school: school)
      elsif user.student?
        existing_memberships = user.school_memberships.active
        existing_memberships.last.update(active: false) if existing_memberships.present?
        user.school_memberships.create(user: user, school: school, active: true)
      end
      redirect_to new_user_invitation_path, notice: "Invitation sent successfully."
    end

    def handle_invitation_failure(user)

      flash.now[:alert] = user.errors.full_messages.join(", ")
      redirect_to new_user_invitation_path
    end

    protected

    def after_accept_path_for(resource)
      if resource.student?
        dashboard_path
      else
        root_path
      end
    end

    private

    def invitation_params
      params.require(:user).permit(:email, :role, :name, :school_id)
    end

    def check_admin_permissions
      unless current_user.admin? || current_user.school_admin?
        redirect_to dashboard_path, alert: 'You do not have permission to access this page.'
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:invite, keys: [:school_id])
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :role, :school_id])
    end
  end
end
