FROM node:alpine

WORKDIR /usr/src/app

COPY . .

ENV PM2_HOME=/tmp

RUN apk update && \
    apk add --no-cache iproute2 vim && \
    npm install -r package.json && \
    npm install -g pm2 && \
    addgroup -g 10014 choreo && \
    adduser -D -H -u 10014 -G choreo choreouser && \
    adduser choreouser wheel && \
    chmod +x web.js entrypoint.sh && \
    npm install -r package.json

USER 10014

ENTRYPOINT ["node", "server.js"]
