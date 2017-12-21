FROM php:7.2-fpm

RUN apt-get update
RUN apt-get install -y \
        git \
        curl \
        python \
        python-pip

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"

RUN python get-pip.py

RUN pip install awscli \
    docker-compose

RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
    && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
    # Make sure we're installing what we think we're installing!
    && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
    && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
    && rm -f /tmp/composer-setup.*