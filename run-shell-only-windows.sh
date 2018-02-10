#!/bin/bash

OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD

docker run -ti \
  --name openworm \
  -e OW_OUT_DIR=$OW_OUT_DIR \
  -e DISPLAY=:44 \
  -v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
  openworm/openworm:0.7 \
  bash

