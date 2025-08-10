#!/bin/bash

echo "Starting Keploy recording with Docker Compose..."

# Clean up any existing containers
docker-compose down >/dev/null 2>&1 || true

# Start Keploy record with Docker Compose in background
keploy record -c "docker compose up" --container-name "fastapi-app" --build-delay 50 &
KEPLOY_PID=$!

# Wait for build delay and additional startup time
echo "Waiting for containers to build and start..."
sleep 60  # 50s build delay + 10s for app startup

# Check if application is ready
echo "Checking if application is ready..."
for i in {1..30}; do
    if curl -s http://127.0.0.1:8000/docs > /dev/null; then
        echo "Application is ready!"
        break
    fi
    echo "Waiting for application... (attempt $i/30)"
    sleep 3
done

# Run the API tests
echo "Running API tests..."
./curls.sh

# Wait a bit for all operations to complete
echo "Waiting for recording to complete..."
sleep 5

# Stop Keploy gracefully
echo "Stopping Keploy recording..."
kill -TERM $KEPLOY_PID 2>/dev/null || true

# Wait for the process to terminate
wait $KEPLOY_PID 2>/dev/null || true

# Clean up containers
echo "Cleaning up containers..."
docker-compose down >/dev/null 2>&1 || true

echo "Recording completed!"
