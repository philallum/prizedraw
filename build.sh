#!/bin/bash

# Exit on error
set -e

echo "Creating necessary directories..."
mkdir -p src/css
mkdir -p dist/css

echo "Installing dependencies..."
npm install

echo "Building CSS..."
npm run build:css

echo "Building HTML..."
npm run build:html

echo "Build completed successfully!" 