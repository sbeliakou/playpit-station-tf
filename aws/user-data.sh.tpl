#!/bin/bash

if df -h | grep /var/lib/docker 
then
  echo /var/lib/docker is already mounted
else
  INSTANCESTORAGE=$(sudo fdisk -l | grep -B1 'Amazon EC2 NVMe Instance Storage' | grep -v model | awk '{print $2}' | cut -d: -f1)
  sudo mkfs -t xfs $${INSTANCESTORAGE}
  sudo mkdir -p /var/lib/docker
  sudo mount $${INSTANCESTORAGE} /var/lib/docker
fi

export USER_NAME="${USER_NAME}"
export DOMAIN_NAME="${DOMAIN_NAME}"
export BASICAUTH="${BASICAUTH}"
export LOGLEVEL="${LOGLEVEL}"
export TRAINING="${TRAINING}"
export SSL="${SSL}"
curl -s http://assets.playpit.net/deploy.sh | bash