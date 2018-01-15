#!/bin/bash

OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD

xhost +

docker run -ti \
  --name openworm-notebook \
  --device=/dev/dri:/dev/dri \
  -e DISPLAY=$DISPLAY \
  -e OW_OUT_DIR=$OW_OUT_DIR \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  --privileged \
  -v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
  openworm/openworm-notebook:0.8 \
  bash

