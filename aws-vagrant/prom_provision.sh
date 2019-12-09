#!/bin/bash

sudo cp /vagrant/prometheus.yml /tmp/
sudo docker container ls | grep prometheus
rc=$?
if [ $rc != 0 ]; then
    sudo docker run --network host -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml -d prom/prometheus
fi
sudo docker service ls | grep node-exporter
rc=$?
if [ $rc != 0 ]; then
    sudo docker service create --name node-exporter --mode global --network monitor --publish published=9100,target=9100,mode=host --endpoint-mode dnsrr prom/node-exporter
fi
sudo docker container ls | grep grafana
rc=$?
if [ $rc != 0 ]; then
    sudo docker run -d -p 3000:3000 grafana/grafana
fi

sudo docker service ls | grep cadvisor
rc=$?
if [ $rc != 0 ]; then
    sudo docker service create --name cadvisor \
    --mount type=bind,source=/var/lib/docker/,destination=/var/lib/docker:ro \
    --mount type=bind,source=/var/run,destination=/var/run:rw \
    --mount type=bind,source=/sys,destination=/sys:ro \
    --mount type=bind,source=/,destination=/rootfs:ro \
    --mode global \
    --network monitor \
    --publish published=8080,target=8080,mode=host \
    --endpoint-mode dnsrr \
    google/cadvisor:latest
fi
