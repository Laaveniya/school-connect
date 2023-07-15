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

3. Set up the database:

```
rails db:create
rails db:migrate
```

4. Start the Elasticsearch service (make sure it is installed and running):

```
elasticsearch

```

alternatively

```
docker-compose -f docker-compose.yml up

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

