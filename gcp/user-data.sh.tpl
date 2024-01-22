#!/bin/bash

export USER_NAME="${USER_NAME}"
export DOMAIN_NAME="${DOMAIN_NAME}"
export BASICAUTH="${BASICAUTH}"
export LOGLEVEL="${LOGLEVEL}"
export TRAINING="${TRAINING}"
export SSL="${USESSL}"
curl -s http://assets.playpit.net/deploy.sh | bash