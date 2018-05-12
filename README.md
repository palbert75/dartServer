# dartServer

This is demo for openshift dart server

# create docker image:

docker  build  -t dartserver .

# run Server

docker run -d -p 8080:8080 dartserver

# attach to docker container

sudo docker exec -i -t  <containerID> /bin/bash
