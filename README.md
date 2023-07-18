# School Management System

The School Management System is an application that allows for the creation and management of schools, courses, batches,
and students by different user types, including Admin, School Admin, and Student. The application provides a flexible
and secure platform for educational organizations to manage their operations effectively.

## Application Requirements

To run the School Management System application, the following requirements must be met:

- Ruby version 2.7.5
- Rails version 7.0.6
- SQLite3 database
- Elasticsearch (for search functionality)

## Getting Started

Follow the steps below to set up and run the School Management System application:

1. Clone the repository:

```
git clone <repository-url>
```

2. Install the required gems:

```
bundle install
```

3. Start the Elasticsearch service (make sure it is installed and running):

```
elasticsearch

```

alternatively with docker

```
docker-compose -f docker-compose.yml up

```

4. Set up the database:

```
rails db:setup
```

5. Start the Rails server:

```
rails server
```

6. Access the application in your web browser at `http://localhost:3000`.

## Running the Test Suite

```
bundle exec rspec
```

## User Types and Responsibilities

The School Management System defines three user types with specific responsibilities:

### Admin

- Admins have full control over the system.
- They can create schools and School Admins.

### School Admin

- SchoolAdmins can update information about their respective schools.
- They are responsible for creating courses.
- They are responsible for creating batches.
- They can add students to batches.
- They can approve or deny enrolment requests made by students.

### Student

- Students can raise a request to enrol in a batch.
- Students from the same batch can see their classmates and their progress.

## Routes

The application provides the following routes:

### Authentication Routes

- `GET /users/sign_in` - User sign-in page
- `DELETE /users/sign_out` - User sign-out

### Admin and School Admin Routes

- `GET /welcome/index` - Home page for admin and school admin users
- `GET /users` - List of users (admin and school admin for schools administered only)
- `GET /users/:id` - User details (admin and school admin for schools administered only)
- `PUT /users/:id` - Update user (admin only and school admin for schools administered only)
- `DELETE /users/:id` - Delete user (admin only and school admin for schools administered only)
- `GET /schools` - List of schools (admin and school admin for schools administered only)
- `GET /schools/:id` - School details (admin and school admin for schools administered only)
- `GET /schools/:id/students` - List of students in a school (admin and school admin)
- `GET /enrollments` - List of enrollments (admin and school admin)
- `GET /enrollments/:id` - Enrollment details (admin and school admin)
- `PUT /enrollments/:id` - Update enrollment (admin and school admin)
- `DELETE /enrollments/:id` - Delete enrollment (admin and school admin)
- `GET /course_batches` - List of course batches (admin and school admin)
- `GET /course_batches/:id` - Course batch details (admin and school admin)
- `PUT /course_batches/:id` - Update course batch (admin and school admin)
- `DELETE /course_batches/:id` - Delete course batch (admin and school admin)
- `GET /courses` - List of courses (admin and school admin)
- `GET /courses/:id` - Course details (admin and school admin)
- `PUT /courses/:id` - Update course (admin and school admin)
- `DELETE /courses/:id` - Delete course (admin and school admin)
- `POST /users/invitation/new` - Create new Invitation (admin and school admin)

### Student Routes

- `GET /dashboard` - Student dashboard
- `POST /enroll_course_batch` - Enroll in a course batch

Please note that only authenticated users with the respective user types can access these routes.

## Default Login Credentials

### Admin User

- Email: admin@example.com
- Password: password

### School Admin Users

- School Admin 1:
    - Email: school_admin_1@example.com
    - Password: password

- School Admin 2:
    - Email: school_admin_2@example.com
    - Password: password

### Student Users

- Student 1:
    - Email: student1@example.com
    - Password: password

- Student 2:
    - Email: student2@example.com
    - Password: password

- Student 3:
    - Email: student3@example.com
    - Password: password

- Student 4:
    - Email: student4@example.com
    - Password: password

## Login

To access the application, you can visit the following URL in your web browser:

- http://localhost:3000/users/sign_in