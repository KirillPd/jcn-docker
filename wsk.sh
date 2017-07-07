#!/bin/bash

#TODO: if [ "$1" == "install" ];

if [ "$1" == "projectstart" ];
then
    #Create the container folder
    mkdir container
    #Run docker container
    docker run -dit -v $(pwd)/container:/var/tmp --name wsk justcoded/wsk
    #Execute jcn inside the container. Move files to tmp folder and install node modules
    docker exec -it wsk sh -c "./dockerrun.sh && mv * ../tmp && cd ../tmp && npm install"
elif [ "$1" == "start" ];
then
    TEST_CONTAINER=$(docker run -p 8080:8080 --name wsk -dit -v $(pwd)/container:/var/app justcoded/wsk) && docker logs $TEST_CONTAINER -f
fi