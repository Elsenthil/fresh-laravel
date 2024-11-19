# Partir de l'image officielle PHP avec Apache
FROM php:8.2-apache

# Installer les dépendances nécessaires (curl, unzip pour Composer)
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && apt-get clean

# Installer Composer globalement
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installer les extensions PHP nécessaires à Laravel (par exemple, pdo_mysql)
RUN docker-php-ext-install pdo pdo_mysql

# Activer le module Rewrite
RUN a2enmod rewrite

# Modifier le DocumentRoot pour pointer vers le dossier public
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf


# Définir le dossier de travail par défaut
WORKDIR /var/www/html
