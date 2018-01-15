#!/bin/bash

OW_OUT_DIR=/home/jovyan/shared
HOST_OUT_DIR=$PWD

xhost +

docker run -d \
  --name openworm-notebook \
  --device=/dev/dri:/dev/dri \
  -e DISPLAY=$DISPLAY \
  -e OW_OUT_DIR=$OW_OUT_DIR \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  --privileged \
  -v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
  -p 8888:8888 \
  openworm/openworm-notebook:0.8 \
  start-notebook.sh --NotebookApp.token=''

echo "open up a browser and point at http://localhost:8888"
