#
FROM ubuntu:trusty
MAINTAINER Frank Mueller "tmp@sysinit.de"

# increase serial to run everything from here again
ENV SERIAL 2015050501

# install needed base packages
RUN apt-get update && apt-get install -y \
	wget \
	vim

# get owncloud repo key
RUN wget -O - http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_8.0/Release.key | apt-key add -
#RUN wget -O - http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_14.04/Release.key | apt-key add -

# add owncloud repo
RUN echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/Debian_8.0/ /' >> /etc/apt/sources.list.d/owncloud.list
#RUN echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud.list
RUN apt-get update

# install owncloud and dependencies
RUN apt-get install -y owncloud

# enable apache modules
RUN /usr/sbin/a2enmod headers && \
    /usr/sbin/a2enmod expires && \
    /usr/sbin/a2enmod cache && \
    /usr/sbin/a2enmod ssl 

# ports
EXPOSE 80 443

#ENV SSL_CRT
#ENV SSL_KEY

# start service
CMD ["/usr/sbin/apache2ctl", "-D",  "FOREGROUND"]
