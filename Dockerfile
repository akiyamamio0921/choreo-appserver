FROM node:latest

WORKDIR /usr/src/app

COPY . .
# COPY ./geo* /tmp/

ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt-get install -y iproute2 vim &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    addgroup --gid 10014 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser &&\
    chmod +x sing-box entrypoint.sh

USER 10014

ENTRYPOINT ["node", "server.js"]
