# Base image: uses an Nginx web server to serve static files
FROM nginx:alpine

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy the frontend folder contents to the Nginx HTML directory
COPY ./frontend /usr/share/nginx/html

# Expose the default HTTP port
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
