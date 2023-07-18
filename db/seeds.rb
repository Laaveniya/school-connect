# Create Admin user
admin = User.create(email: 'admin@example.com', password: 'password', role: 'admin', name: 'Admin')

# Create SchoolAdmin user
school_admin = User.create(email: 'school_admin_1@example.com', password: 'password', role: 'school_admin', name: 'School Admin')
school_admin_2 = User.create(email: 'school_admin_2@example.com', password: 'password', role: 'school_admin', name: 'School Admin 2')

# Create Schools
school1 = School.create(name: 'School 1', address: 'Address 1', creator_id: admin.id)
school2 = School.create(name: 'School 2', address: 'Address 2', creator_id: admin.id)

# CreateAdminships
Adminship.create(school_id: school1.id, user_id: school_admin.id)
Adminship.create(school_id: school2.id, user_id: school_admin_2.id)

# Create Student users
student1 = User.create(email: 'student1@example.com', password: 'password', role: 'student', name: 'Student 1')
student2 = User.create(email: 'student2@example.com', password: 'password', role: 'student', name: 'Student 2')
student3 = User.create(email: 'student3@example.com', password: 'password', role: 'student', name: 'Student 3')
student4 = User.create(email: 'student4@example.com', password: 'password', role: 'student', name: 'Student 4')

# Create SchoolMemberships
SchoolMembership.create(user_id: student1.id, school_id: school1.id, active: true)
SchoolMembership.create(user_id: student2.id, school_id: school1.id, active: true)
SchoolMembership.create(user_id: student3.id, school_id: school2.id, active: true)
SchoolMembership.create(user_id: student4.id, school_id: school2.id, active: true)

# Create Courses
course1 = Course.create(name: 'Course 1', school: school1, description: 'Description 1', creator_id: school_admin.id, start_date: Date.current, end_date: Date.current + 30.days)
course2 = Course.create(name: 'Course 2', school: school2, description: 'Description 2', creator_id: admin.id, start_date: Date.current, end_date: Date.current + 30.days)

# Create Batches
batch1 = CourseBatch.create(name: 'Batch 1', course: course1, creator_id: school_admin.id, max_enrollment_count: 10, start_date: Date.current, end_date: Date.current + 30.days)
batch2 = CourseBatch.create(name: 'Batch 2', course: course1, creator_id: school_admin.id, max_enrollment_count: 10, start_date: Date.current, end_date: Date.current + 30.days)
batch3 = CourseBatch.create(name: 'Batch 3', course: course2, creator_id: admin.id, max_enrollment_count: 10, start_date: Date.current, end_date: Date.current + 30.days)
batch4 = CourseBatch.create(name: 'Batch 4', course: course2, creator_id: admin.id, max_enrollment_count: 10, start_date: Date.current, end_date: Date.current + 30.days)

# Create Enrollments (Request to Enrol in Batch)
enrollment1 = Enrollment.create(student: student1, course_batch_id: batch1.id, status: 'requested')
enrollment2 = Enrollment.create(student: student2, course_batch_id: batch1.id, status: 'requested')
Enrollment.create(student: student3, course_batch_id: batch3.id, status: 'requested')
Enrollment.create(student: student4, course_batch_id: batch4.id, status: 'denied')

# Approve Enrollments
enrollment1.update(status: 'approved', approver_id: school_admin)
enrollment2.update(status: 'approved', approver_id: school_admin)