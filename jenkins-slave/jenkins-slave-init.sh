#!/bin/sh

if [ "$JENKINS_SLAVE_SSH_NO_STRICT_CHECK" == "true" ]; then
  mkdir $HOME/.ssh
  cp /opt/jenkins-slave/ssh/config $HOME/.ssh/
fi

java -jar swarm-client-3.9.jar -master http://$MASTER_PORT_8080_TCP_ADDR:$MASTER_PORT_8080_TCP_PORT $EXTRA_PARAMS
