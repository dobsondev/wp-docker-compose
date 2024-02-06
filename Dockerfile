# Use the official Nginx image
FROM nginx:latest

# Install PHP and necessary PHP extensions
RUN apt-get update && \
    apt-get install -y php8.2-fpm php8.2-mysql

# Copy Nginx configuration file
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start PHP-FPM and Nginx
CMD /etc/init.d/php8.2-fpm start -F && nginx -g "daemon off;"