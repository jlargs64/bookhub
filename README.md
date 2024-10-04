# bookhub

A cloud native book app meant to demonstrate competency with Django/React/Postgresql/Docker &amp; Docker Compose/ and Kafka.

# Frontend

## Local Development

1. Run the `npm i` command in the `frontend/` directory to install all required packages.

# Backend

## Local Development

1. Run the `pip install -r requirements.txt` command in the `backend/` directory to install all required packages.

# Services

We are using LocalStack to emulate AWS Services like RDS (Postgres DB), MSK (Kafka), and more. Details can be found in the root `docker-compose.yml` file.

## Set up

1. `docker-compose up -d`
1. `cd terraform`
1. `terraform init`
1. `terraform apply`
