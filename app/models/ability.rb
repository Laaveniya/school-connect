class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, School
      can :manage, Adminship
      can :manage, Course
    elsif user.school_admin?
      can :manage, School, id: user.schools_administered.pluck(:school_id)
      cannot :create, School
      can :manage, Course
    end
  end
end
