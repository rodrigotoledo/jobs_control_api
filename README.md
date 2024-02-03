# Job Control API

## Description

Job Control API is a Ruby on Rails API that provides comprehensive features for job posting, applications, and user management.

## Technologies Used

- Ruby on Rails
- PostgreSQL
- Devise for authentication

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

The API uses Devise for user authentication. To authenticate requests, include the user's token in the request headers.

### Sign UP a User

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

### Sign IN a User

Send a POST request to `/sign_in` with parameters:

```json
{
  "user": {
    "email": "example@example.com",
    "password": "password"
  }
}
```
