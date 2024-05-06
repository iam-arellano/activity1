FROM php:8.1.6-apache


ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y tcl


RUN apt-get update && apt-get install -y \
    curl \
    nano \
    git \
    wget \
    iputils-ping

# ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
# RUN chmod +x /usr/local/bin/install-php-extensions \
#         && install-php-extensions mongodb


# COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# COPY apache2.conf /etc/apache2/sites-available/000-default.conf
# RUN a2enmod rewrite

COPY . /var/www/html
RUN chown -R $USER:www-data /var/www/html
RUN chmod -R 775 /var/www/html



EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]