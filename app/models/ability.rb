class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user
    can :students, School do |school|
      user.schools_administered.include?(school) || user.admin?
    end

    if user.admin?
      can :manage, User
      can :manage, School
      can :manage, Adminship
      can :manage, Course
      can :manage, CourseBatch
      can :manage, Enrollment
    elsif user.school_admin?
      can :manage, User, adminships: { school_id: user.schools_administered.pluck(:id) }
      can :manage, School, id: user.schools_administered.pluck(:id)
      cannot :create, School
      can :manage, Course, school: user.schools_administered
      can :manage, CourseBatch, course: { school: user.schools_administered }
      can :manage, Enrollment, course_batch: { course: { school: user.schools_administered } }
    elsif user.student?
      can :read, User, id: user.classmates.pluck(:id)
      can :read, School, id: user.school_memberships.pluck(:school_id)
      can :read, CourseBatch, id: user.school.course_batches.pluck(:id)
      can :read, Enrollment, student: user
      can :create, Enrollment, course_batch_id: user.school.course_batches.pluck(:id)
      can :dashboard, User, id: user.id
      can :enroll_course_batch, User, id: user.id
    end
  end
end
