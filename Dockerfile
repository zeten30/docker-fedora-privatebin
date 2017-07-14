FROM fedora:latest
MAINTAINER Milan Zink <zeten30@gmail.com>

# Install httpd + php, remove welcome.conf & create user
RUN dnf --setopt=tsflags=nodocs -y install \
    git \
    php \
    php-opcache \
    php-gd php-intl \
    php-mbstring \
    php-mcrypt \
    php-xml \
    httpd \
    httpd-tools \
    wget \
    unzip 2> /dev/null && \
    dnf clean all && \
    rm /etc/httpd/conf.d/welcome.conf && \
    adduser --uid 10000 --comment 'PrivateBin Apache User' --home-dir /opt/privatebin privatebin

# Run all under privatebin user
USER privatebin

# Create directories
# link *conf*.d, modules & magic file
# git clone privatebin app
RUN mkdir /opt/privatebin/logs /opt/privatebin/run /opt/privatebin/www /opt/privatebin/conf && \
    ln -s /etc/httpd/conf.d /opt/privatebin/conf.d && \
    ln -s /etc/httpd/conf.modules.d /opt/privatebin/conf.modules.d && \
    ln -s /usr/lib64/httpd/modules /opt/privatebin/modules && \
    ln -s /etc/httpd/conf/magic /opt/privatebin/conf/magic && \
    git clone https://github.com/PrivateBin/PrivateBin.git /opt/privatebin/www/

# Copy config files
COPY httpd.conf /opt/privatebin/
COPY conf.ini /opt/privatebin/www/cfg/

# Announce volume
VOLUME ["/opt/privatebin/data"]

# Switch to homedir as working dir
WORKDIR /opt/privatebin/

# Copy startup script
COPY ./httpd.sh /httpd.sh

# We listen on 8080
EXPOSE 8080

# GO! :)
CMD ["/httpd.sh"]
