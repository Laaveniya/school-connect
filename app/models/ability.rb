class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user
    can :students, School do |school|
      user.schools_administered.include?(school) || user.admin?
    end

    if user.admin?
      can :manage, School
      can :manage, Adminship
      can :manage, Course
      can :manage, CourseBatch
      can :manage, Enrollment
    elsif user.school_admin?
      can :manage, School, id: user.schools_administered.pluck(:school_id)
      cannot :create, School
      can :manage, Course, school_id: user.schools_administered.pluck(:id)
      can :manage, CourseBatch, course: { school_id: user.schools_administered.pluck(:id) }
      can :manage, Enrollment, course_batch: { course: { school: user.schools_administered } }
    end
  end
end
