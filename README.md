# Jungle

Lighthouse Labs Web Development Bootcamp Project 4. 

Jungle is a mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example. This project simulated being dropped into an existing codebase with unfamiliar languages and frameworks and have us modify it with new features and bug fixes. Automated testing using RSpec was also added.


## Jungle Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars

### Running Jungle Server

`bin/rails server`

### If running on Vagrant Virtual machine use:

`bin/rails server -b 0.0.0.0`

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Model Testing
To run all automated RSpec model tests.

`bin/rspec [--format documentation]`

## Feature Testing
Feature tests are executed using Capybara and Poltergeist. These tests are much slower than model tests so running only the one you might be working on is recommended:

`bin/rspec spec/features/filename_spec.rb`
