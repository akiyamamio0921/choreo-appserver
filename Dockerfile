FROM node:alpine

WORKDIR /usr/src/app

COPY . .

ENV PM2_HOME=/tmp

RUN apk update && \
    apk add --no-cache iproute2 vim curl bash && \
    npm install package.json && \
    npm install -g pm2 && \
    addgroup -g 10014 choreo && \
    adduser -D -H -u 10014 -G choreo choreouser && \
    chmod +x web.js entrypoint.sh && \

USER 10014

ENTRYPOINT ["node", "server.js"]
