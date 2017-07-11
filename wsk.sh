#!/bin/bash

if [ "$1" == "project-start" ]; then
    #Create the container folder
    mkdir container
    #Run docker container
    CONTAINER=$(docker run -dit -v $(pwd)/container:/var/tmp --name wsk 39281706/wsk)
    #Execute jcn inside the container. Move files to tmp folder, delete Docker's files and install node modules
    docker exec -it $CONTAINER sh -c "./dockerrun.sh && rm -rf ../tmp/* && mv -f * ../tmp && cd ../tmp && find . -maxdepth 1 -iname \"[Dd]ocker*\" -delete && exit"
    cd container && npm install
    docker exec -it $CONTAINER sh -c "cd /var/tmp && npm install jpegtran-bin --no-bin-links && npm rebuild node-sass --force --no-bin-links && exit"
    #Stop and remove docker container
    docker kill $CONTAINER && docker rm $CONTAINER
elif [ "$1" == "serve" ]; 
then
    CONTAINER=$(docker run -dit $CONTAINER --expose 8080 -p 8080:8080 -v $(pwd)/container:/var/app 39281706/wsk npm start) && docker logs $CONTAINER -f
elif [ "$1" == "production" ]; 
then
    CONTAINER=$(docker run -dit -v $(pwd)/container:/var/app 39281706/wsk npm run production) && docker logs $CONTAINER -f
    #Stop and remove docker container
    docker stop $CONTAINER && docker rm $CONTAINER
elif [ "$1" == "develop" ]; 
then
    CONTAINER=$(docker run -dit -v $(pwd)/container:/var/app 39281706/wsk npm run develop) && docker logs $CONTAINER -f
    #Stop and remove docker container
    docker stop $CONTAINER && docker rm $CONTAINER
fi