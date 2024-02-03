# Job Control API

## Description

Job Control API is a Ruby on Rails API that provides comprehensive features for job posting, applications, and user management.

## Technologies Used

- Ruby on Rails
- Custom DATABASE
- Native SignUp and SingIn from Rails
- RSpec for testing

## How to Run Locally

1. Clone the repository.
2. Install dependencies with `bundle install`.
3. Configure the database with `rails db:setup`.
4. Run migrations with `rails db:migrate`.
5. Start the server with `rails server`.

## Project Structure

The project follows a standard Rails application structure with folders such as `app`, `config`, `db`, and `lib`. Key files include `Gemfile`, `config/database.yml`, and `config/routes.rb`.

## Available Endpoints/APIs

Running `rails routes` its possible to see the routes that are available

## Authentication and Authorization

### Sign UP

The API uses Native SignUP methods for user authentication.

Send a POST request to `/sign_up` with parameters:

```json
{
  "user": {
    "email": "example@example.com",
    "password": "password",
    "password_confirmation": "password"
    //other fields
  }
}
```

### Sign IN

The API uses Native SignUP methods for user authentication.

Send a POST request to `/sign_in` with parameters:

```json
{
  "email": "example@example.com",
  "password": "password"
}
```

## Jobs

Each User can create jobs that can be applied to other users. He will decide wich user will be applied to the specified job.

In another point the same User can have multiple applications in different jobs.

The actions to decide wich user will be applied or unapplied to the specified job depends of the owner of the job.

## Tests

This application uses RSpec with TDD to testing. So run the following command:

```bash
bundle exec guard
```

And each changes that occur will run the tests against. The results will be in the file `coverage/index.html`.
