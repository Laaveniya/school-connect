class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, School
      can :manage, Adminship
      can :manage, Course
      can :manage, CourseBatch
    elsif user.school_admin?
      can :manage, School, id: user.schools_administered.pluck(:school_id)
      cannot :create, School
      can :manage, Course, school_id: user.schools_administered.pluck(:id)
      can :manage, CourseBatch, course: { school_id: user.schools_administered.pluck(:id) }
    end
  end
end
