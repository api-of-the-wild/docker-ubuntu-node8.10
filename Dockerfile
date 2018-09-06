FROM ubuntu:18.04

# Ensure BASH is used for Jenkins pipelines
# TODO: Better way to accomplish this?
RUN rm /bin/sh \
  && ln -s /bin/bash /bin/sh

# Packages to
# * Acquire dependencies
ENV ACQUIRE_DEPENDENCIES "apt-transport-https ca-certificates curl gnupg"
# * Clone repositories
ENV CLONE_REPOSITORIES "git openssh-client"

RUN apt update \
  && apt install -y -q --no-install-recommends \
  ${ACQUIRE_DEPENDENCIES} \
  ${CLONE_REPOSITORIES}

# Install node.js 8.x
RUN apt-get update -yq \
  && apt-get install curl gnupg -yq \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash \
  && apt-get install nodejs -yq

# Check node.js install
RUN node -v \
  && npm -v \
  && npm i -g nodemon \
  && nodemon -v
# && npm i -g yarn \
# && yarn --version

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  apt-get update \
  && yes Y | apt-get install --no-install-recommends yarn

# Check yarn install
RUN yarn --version
