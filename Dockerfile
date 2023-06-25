FROM node:alpine

WORKDIR /usr/src/app

COPY . .

ENV PM2_HOME=/tmp

RUN apk update && \
    apk add --no-cache iproute2 vim &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    addgroup --gid 10014 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser &&\
    chmod +x web.js entrypoint.sh &&\
    npm install -r package.json

USER 10014

ENTRYPOINT ["node", "server.js"]
