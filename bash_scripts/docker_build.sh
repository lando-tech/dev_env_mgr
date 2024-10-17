#!/bin/bash

if docker --version; then
    echo Docker is already installed
    echo Running docker build...
    docker build -t dev_env:1.0 ./
else
    echo Installing Docker
    ./docker_install.sh

    if docker --version; then
        echo Install complete, happy coding!
    fi
fi
