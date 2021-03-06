FROM node:4.1.1-slim
MAINTAINER Ash Wilson <smashwilson@gmail.com>

RUN apt-get update && apt-get install -y git
RUN npm install -g coffee-script
RUN useradd pushbot
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app
ADD package.json /usr/src/app/package.json
RUN npm install .
ADD . /usr/src/app
RUN chown -R pushbot:pushbot /usr/src/app

USER pushbot
ENTRYPOINT ["/usr/src/app/node_modules/.bin/hubot", "-a", "slack"]
