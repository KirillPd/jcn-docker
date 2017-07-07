FROM node:boron

RUN mkdir -p /var/tmp
RUN mkdir -p /var/app

COPY ./ /var/app
WORKDIR /var/app

RUN npm install jcn -g
RUN chmod +x ./dockerrun.sh
