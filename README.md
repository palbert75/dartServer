# dartServer

This is demo for openshift dart server

# Create docker image:

docker  build  -t dartserver .

# run Server

docker run -d -p 8080:8080 dartserver

# Attach to docker container

sudo docker exec -i -t  [containerID] /bin/bash

or

docker run -p 8080:8080  -it --entrypoint /bin/bash dartserver

# Add docker image to docker hub

docker tag  dartserver palbert75/dartserver:latest
docker push palbert75/dartserver:latest


# From docker hub
docker pull palbert75/dartserver
docker run -d -p 8080:8080 palbert75/dartserver


# OpenShift add app

oc new-app palbert75/dartserver
oc expose svc/dartserver

oc import-image dartSerer:1.1 --from=palbert75/dartserver

# Helm cli

helm list

helm delete --purge [releasename]

helm install -n <name of install>  .

Change chart version in chart.yaml before each deploy

helm upgrade [name of install] .

oc get pod  (List of pods)


oc logs -f [pod name]
