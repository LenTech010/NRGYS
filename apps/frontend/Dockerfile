# Use official Node image (Node 20.19.4 for Expo/React Native 0.81+)
FROM node:20.19.4-alpine

WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Expose Expo's default port
EXPOSE 8081

# Start Expo CLI in tunnel mode (good for most dev environments)
CMD ["npx", "expo", "start", "--tunnel"]