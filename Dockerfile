FROM ubuntu:12.04
MAINTAINER gijs@pythonic.nl
ENV DEBIAN_FRONTEND noninteractive

ADD docker/apt.sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

ADD docker/PureWeb_Ubuntu_Setup-4.1.2.deb /
RUN dpkg -i /PureWeb_Ubuntu_Setup-4.1.2.deb

RUN apt-get install -y xvfb liblapack3gf libicu48 libgomp1 libqtscript4-opengl libapache2-mod-wsgi apache2 curl python-pip python-dev openjdk-7-jdk supervisor
RUN pip install Flask Flask-SQLAlchemy

ADD docker/app-4.2.1 /opt/CSI/PureWeb/Server/
ADD docker/vizserv /var/vizserv/
ADD docker/default_settings.py  /var/vizserv/vizserv/default_settings.py
ADD docker/apache  /etc/apache2/sites-available/cyberskaviewer
ADD docker/sfviewer.config /root/.sfviewer.config
ADD docker/supervisord.conf /etc/supervisor/conf.d/cyberskaviewer.conf
ADD docker/ROOT.xml /opt/CSI/PureWeb/Server/tomcat/conf/Catalina/localhost/ROOT.xml
ADD docker/error.fits /opt/CSI/

ENV HOME /root

RUN a2ensite cyberskaviewer
RUN a2dissite 000-default

# Patch broken symlink
RUN rm -f /opt/CSI/PureWeb/Server/webapp/FitsViewer/thirdParty/pureweb.min.js
RUN ln -s /opt/CSI/PureWeb/SDK/Redistributable/Libs/HTML5/pureweb.min.js /opt/CSI/PureWeb/Server/webapp/FitsViewer/thirdParty/pureweb.min.js

# Create missing temp directory:
RUN mkdir /opt/CSI/PureWeb/Server/tomcat/temp

RUN mkdir /var/run/apache2/
RUN chown www-data:www-data /var/vizserv/ -R

EXPOSE 8080/tcp
EXPOSE 80/tcp

CMD ["/usr/bin/supervisord"]
