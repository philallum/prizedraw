FROM node:18.17.0-alpine

WORKDIR /app

# Install dependencies including curl
RUN apk add --no-cache curl

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Expose port
EXPOSE 8888

# Start the application
CMD ["npm", "run", "start"] 