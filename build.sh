#!/bin/bash

# Exit on error
set -e

echo "Installing dependencies..."
npm install

echo "Building CSS..."
npm run build:css

echo "Building HTML..."
npm run build:html

echo "Build completed successfully!" 