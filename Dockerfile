FROM anapsix/alpine-java:8u102b14_server-jre_unlimited
MAINTAINER Ladislav Gazo <gazo@seges.sk>

USER root

#RUN locale-gen en_US.UTF-8
#RUN dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "http://dl-6.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && \
    apk add docker py-pip wget curl git

RUN pip install docker-compose

ADD /jenkins-slave /opt/
WORKDIR /opt/jenkins-slave

RUN wget http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar -O /opt/jenkins-slave/swarm-client-2.0-jar-with-dependencies.jar
CMD ash /opt/jenkins-slave-init.sh
#CMD java -jar swarm-client-2.0-jar-with-dependencies.jar -master http://$MASTER_PORT_8080_TCP_ADDR:$MASTER_PORT_8080_TCP_PORT $EXTRA_PARAMS

# Load scripts
#COPY bootstrap/ /bootstrap/
#RUN chmod +x -Rv /bootstrap

# Add user jenkins to the image
#RUN adduser -D -h /home/jenkins -s /bin/ash jenkins
#RUN adduser jenkins docker

#CMD /opt/jenkins-slave/jenkins-slave-init.sh

