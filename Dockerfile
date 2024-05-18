# Stage 1: Build
FROM node:16-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run

# Stage 2: Production
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=builder /app ./

# Install only production dependencies
RUN npm install --only=production

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
