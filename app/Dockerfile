FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy files to the working directory
COPY . .

# Install dependencies
RUN npm install

# Expose the port your app runs on.
# Needed for OpenShift to inspect
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["node", "server.js"]