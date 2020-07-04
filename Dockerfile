FROM wordpress:latest

# change uplaod size
RUN /bin/bash -c "sed -i 's/^post_max_size.*/post_max_size = 512M/' /usr/local/etc/php/php.ini-production"
RUN /bin/bash -c "sed -i 's/^upload_max_filesize.*/upload_max_filesize = 512M/' /usr/local/etc/php/php.ini-production"

# move php.ini to production
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

#add SES keys
RUN echo >> /var/www/html/wp-config.php
RUN echo #SES offload lite aws credendtials >> /var/www/html/wp-config.php
RUN echo "define( 'WPOSES_AWS_ACCESS_KEY_ID',     getenv('WPOSES_AWS_ACCESS_KEY_ID') );" >> /var/www/html/wp-config.php
RUN echo "define( 'WPOSES_AWS_SECRET_ACCESS_KEY',     getenv('WPOSES_AWS_SECRET_ACCESS_KEY') );" >> /var/www/html/wp-config.php

#remove plugins
RUN rm -f /var/www/html/plugins/hello.php
RUN rm -r -f /var/www/html/plugins/akismet

#add plugins
ADD plugins /var/www/html/plugins
