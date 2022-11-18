FROM ubuntu
MAINTAINER Valera Rozuvan version: 0.1
RUN apt-get update && apt-get install -y apache2 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/apache2/ports.conf
COPY 000-default.conf /etc/apache2/sites-available/
COPY apache2.conf /etc/apache2/

RUN mkdir -p /var/apache2_run_dir

RUN chown -R www-data:www-data /var/www
RUN chmod u+rwx,g+rx,o+rx /var/www
RUN find /var/www -type d -exec chmod u+rwx,g+rx,o+rx {} +
RUN find /var/www -type f -exec chmod u+rw,g+rw,o+r {} +

RUN chown -R www-data:www-data /var/log/apache2
RUN chmod u+rwx,g+rx,o+rx /var/log/apache2
RUN find /var/log/apache2 -type d -exec chmod u+rwx,g+rx,o+rx {} +
RUN find /var/log/apache2 -type f -exec chmod u+rw,g+rw,o+r {} +

RUN chown -R www-data:www-data /var/apache2_run_dir
RUN chmod u+rwx,g+rx,o+rx /var/apache2_run_dir
RUN find /var/apache2_run_dir -type d -exec chmod u+rwx,g+rx,o+rx {} +
RUN find /var/apache2_run_dir -type f -exec chmod u+rw,g+rw,o+r {} +

USER www-data

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/apache2_run_dir
ENV APACHE_PID_FILE /var/apache2_run_dir/.pid

RUN mkdir -p /var/www/html
COPY index.html /var/www/html/
COPY robots.txt /var/www/html/

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
