# Sismology App Backend

This repository contains the backend for the Sismology application, providing an API to manage seismic features and their comments.

## Requirements

- Ruby (version 3.2.2)
- Ruby on Rails (version 7.1.2)
- PostgreSQL

## Setup
1. Clone this repository to your local machine.
1. Install the required gems by running bundle install.
1. Configure your PostgreSQL database in config/database.yml.
1. Run rails db:create to create the database.
1. Run rails db:migrate to apply migrations.
1. Optionally, you can run rails db:seed to load sample data.

## Usage
### API Endpoints
#### GET (/api/features)
This endpoint returns all seismic features stored in the database. You can filter features by magnitude type using the mag_type query parameter.

example request:
```ruby
curl --request GET \
--url 'http://localhost:3000/api/features?filters%5Bmag_type%5D=magnitude_type' \
--header 'Content-Type: application/json'
```

#### POST (/api/features/:id/comments)
This endpoint allows you to create a comment for a specific seismic feature identified by its ID. You need to provide the comment body in the request body.
```ruby
curl --request POST \
--url 'http://localhost:3000/api/features/1/comments' \
--header 'Content-Type: application/json' \
--data '{"body": "This is a comment"}'
```

