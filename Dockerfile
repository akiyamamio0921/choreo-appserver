FROM node:16-bullseye

WORKDIR /usr/src/app

COPY . .

ENV PM2_HOME=/tmp

RUN set -ex \
    && yarn install \
    && yarn global add pm2 \
    && chmod +x sing-box entrypoint.sh \
    && addgroup --gid 10014 choreo \
    && adduser --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser \
    && usermod -aG sudo choreouser
   
USER 10014

ENTRYPOINT ["yarn", "start"]
