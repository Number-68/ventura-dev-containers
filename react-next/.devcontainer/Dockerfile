# base image
FROM ubuntu:22.04


# download node essentials and git
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential


# node installation
ARG NODE_VERSION=20
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs


# user add for permissions
RUN useradd -ms /bin/bash devuser
USER devuser


WORKDIR /workspace


