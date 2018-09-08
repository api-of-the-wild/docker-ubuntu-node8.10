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
  && npm i -g yarn \
  && yarn -v
