FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY . ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on.
# Needed for OpenShift to inspect
EXPOSE 8080

# Command to run the application
CMD ["node", "server.js"]