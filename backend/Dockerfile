# Use a lightweight Node.js base image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy dependency files
COPY package.json package-lock.json ./

# Ensure devDependencies (tsc, ts-node, etc.) are installed during build
ENV NPM_CONFIG_PRODUCTION=false
RUN npm install --include=dev

# Copy all remaining source code
COPY . .

# Build TypeScript to JavaScript
RUN npm run build

# Expose port 3000 for the backend
EXPOSE 3000

# Run compiled JavaScript
CMD ["node", "dist/server.js"]