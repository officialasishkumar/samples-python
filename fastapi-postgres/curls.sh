#!/bin/bash

# API testing script for FastAPI-Postgres CRUD application
# This script makes API calls to test Keploy recording

echo "Starting API calls for Keploy recording..."

# Wait for the application to start
sleep 3

# Create first student - Eva White
echo "Creating student: Eva White"
curl --location 'http://127.0.0.1:8000/students/' \
--header 'Content-Type: application/json' \
--data-raw '{
      "name": "Eva White",
      "email": "evawhite@example.com",
      "password": "evawhite111"
    }' || echo "Failed to create Eva White"
echo ""

sleep 1

# Create second student - John Doe
echo "Creating student: John Doe"
curl --location 'http://127.0.0.1:8000/students/' \
--header 'Content-Type: application/json' \
--data-raw '{
      "name": "John Doe",
      "email": "johndoe@example.com",
      "password": "johndoe123"
    }' || echo "Failed to create John Doe"
echo ""

sleep 2

# Get all students
echo "Getting all students"
curl --location 'http://127.0.0.1:8000/students/' || echo "Failed to get all students"
echo ""

sleep 2

# Get specific student by ID
echo "Getting student with ID 1"
curl --location 'http://127.0.0.1:8000/students/1' || echo "Failed to get student 1"
echo ""

sleep 2

# Update student with ID 2
echo "Updating student with ID 2"
curl --location --request PUT 'http://127.0.0.1:8000/students/2' \
--header 'Content-Type: application/json' \
--data-raw '{
        "name": "John Dow",
        "email": "doe.john@example.com",
        "password": "johndoe123",
        "stream": "Arts"
    }' || echo "Failed to update student 2"
echo ""

sleep 2

# Delete student with ID 1
echo "Deleting student with ID 1"
curl --location --request DELETE 'http://127.0.0.1:8000/students/1' || echo "Failed to delete student 1"
echo ""

sleep 2

echo "All API calls completed!"
