#!/bin/bash

containers=$(docker ps -f label=autocaddy -q)
for container in $containers; do
    docker kill --signal="SIGUSR1" $container
done
