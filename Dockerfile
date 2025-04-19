FROM node:18.17.0-alpine

WORKDIR /app

# Install dependencies including curl and necessary build tools
RUN apk add --no-cache curl bash

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Set proper permissions
RUN chmod -R 755 /app/dist

# Expose port
EXPOSE 8888

# Start the application
CMD ["npm", "run", "start"] 