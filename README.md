# dartServer

This is demo for openshift dart server

# create docker image:

docker  build  -t dartserver .

# run Server

docker run -d -p 8080:8080 dartserver

# attach to docker container

sudo docker exec -i -t  [containerID] /bin/bash

or

docker run -p 8080:8080  -it --entrypoint /bin/bash dartserver

# Add docker imega to docker hub

docker tag  dartserver palbert75/dartserver:latest
docker push palbert75/dartserver:latest


# from docker hub
docker pull palbert75/dartserver
docker run -d -p 8080:8080 palbert75/dartserver


# OpenShift add app

oc new-app palbert75/dartserver:latest --name myserver
oc expose svc myserver --name=myserverwelcome

oc import-image myserver:1.1 --from=palbert75/dartserver:latest


