#!/bin/bash

#TODO: if [ "$1" == "install" ];

if [ "$1" == "projectstart" ];
then
    #Create the container folder
    mkdir container
    #Run docker container
    CONTAINER=$(docker run -dit -v $(pwd)/container:/var/tmp --name wsk justcoded/wsk)
    #Execute jcn inside the container. Move files to tmp folder, delete Docker's files and install node modules
    docker exec -it $CONTAINER sh -c "./dockerrun.sh && mv * ../tmp && cd ../tmp && find . -maxdepth 1 -iname \"[Dd]ocker*\" -delete && npm install && exit"
    #Stop and remove docker container
    docker stop $CONTAINER && docker rm $CONTAINER
elif [ "$1" == "start" ];
then
    CONTAINER=$(docker run -p 8080:8080 -dit -v $(pwd)/container:/var/app justcoded/wsk npm start) && docker logs $CONTAINER -f
fi