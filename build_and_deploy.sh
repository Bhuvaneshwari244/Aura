#!/bin/bash
# Build frontend and prepare for single deployment

echo "Building frontend..."
cd frontend
npm install
npm run build
cd ..

echo "Frontend built successfully!"
echo "Ready to deploy from backend folder"
