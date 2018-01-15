FROM jupyter/datascience-notebook:db3ee82ad08a

MAINTAINER David Lung "lungdm@gmail.com"

ARG USR=jovyan
ENV USER=$USR

USER root

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get dist-upgrade -y

RUN mkdir -p /etc/sudoers.d && \
  export uid=1000 gid=1000 && \
  mkdir -p /home/$USER && \
  echo "$USER:x:${uid}:${gid}:$USER,,,:/home/$USER:/bin/bash" >> /etc/passwd && \
  echo "$USER:x:${uid}:" >> /etc/group && \
  echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
  chmod 0440 /etc/sudoers.d/$USER && \
  chown ${uid}:${gid} -R /home/$USER

ENV DEBIAN_FRONTEND noninteractive # TODO: change

#RUN useradd -ms /bin/bash $USER

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
  wget \
  nano \
  htop \
  git \
  rpm \
  zlib1g-dev \
  bison \
  flex \
  libreadline6 libreadline6-dev \
  automake \
  autoconf \ 
  libtool \
  libncurses5-dev \
  lsb-core \
  sudo \
  xorg \
  openbox \
  libxml2-dev libxslt-dev \
  x11-xserver-utils \
  libxext-dev mercurial \
  freeglut3-dev libglu1-mesa-dev libglew-dev \
  kmod dkms \
  linux-source linux-headers-generic \
  maven openjdk-8-jdk \
  libnuma1 \
  openmpi-bin  libopenmpi-dev \
  libgl1-mesa-glx libgl1-mesa-dri libfreetype6-dev \ 
  libpng12-dev libxft-dev xubuntu-desktop ffmpeg xvfb tmux

RUN sudo usermod -a -G video $USER

USER $USER
ENV HOME /home/$USER
WORKDIR $HOME

RUN mkdir neuron && \
  cd neuron && \
  #git clone https://github.com/nrnhines/iv.git && \
  git clone https://github.com/nrnhines/nrn.git && \
  #cd iv && \
  #git checkout 76c123b && \
  #./build.sh && \
  #./configure --prefix=`pwd` && \
  #make && \
  #make install && \
  #cd ../nrn && \
  cd nrn && \
  git checkout e0950a1 && \
  ./build.sh && \
  ./configure --prefix=`pwd` --without-memacs --without-iv --with-nrnpython=/opt/conda/bin/python --with-paranrn && \
  make && \
  make install && \
  cd src/nrnpython && \
  python setup.py install

USER root

RUN wget https://s3-us-west-1.amazonaws.com/openworm/OpenWorm-OpenCL-Stack-extras.zip && unzip OpenWorm-OpenCL-Stack-extras.zip && \
  mkdir intel-opencl-tmp && mv SRB5.0_linux64.zip intel-opencl-tmp/ && mv silent-intel-sdk.cfg /tmp/silent-intel-sdk.cfg && rm OpenWorm-OpenCL-Stack-extras.zip

ARG INTEL_SDK_VERSION=2017_7.0.0.2511_x64

RUN cd intel-opencl-tmp && \
  mkdir intel-opencl && \
  unzip SRB5.0_linux64.zip && \
  tar -C intel-opencl -Jxf intel-opencl-r5.0-63503.x86_64.tar.xz && \
  tar -C intel-opencl -Jxf intel-opencl-devel-r5.0-63503.x86_64.tar.xz && \
  tar -C intel-opencl -Jxf intel-opencl-cpu-r5.0-63503.x86_64.tar.xz && \
  cp -R intel-opencl/* / && \
  ldconfig && \
  cd .. && \
  rm -r intel-opencl-tmp

RUN tar xvf intel_sdk_for_opencl_$INTEL_SDK_VERSION.tgz && \
  cd intel_sdk_for_opencl_$INTEL_SDK_VERSION && \
  ./install.sh --silent /tmp/silent-intel-sdk.cfg && \
  cd $HOME && \
  rm intel_sdk_for_opencl_$INTEL_SDK_VERSION.tgz && \
  rm /tmp/silent-intel-sdk.cfg

USER $USER

RUN git clone https://github.com/NeuroML/jNeuroML.git && \
  chown -R $USER jNeuroML && \
  cd jNeuroML && \
  git checkout 485e905 && \
  python2 getNeuroML.py ow-0.1
  
RUN git clone https://github.com/lungd/pyNeuroML.git && \
  chown -R $USER pyNeuroML && \
  cd pyNeuroML && \
  git checkout ow-0.1 && \
  python setup.py install

RUN git clone https://github.com/openworm/PyOpenWorm.git && \
  chown -R $USER PyOpenWorm && \
  cd PyOpenWorm && \
  git checkout 7ff1266 && \
  python setup.py install

RUN git clone https://github.com/lungd/CElegansNeuroML.git && \
  chown -R $USER CElegansNeuroML && \
  cd CElegansNeuroML && \
  git checkout ow-0.1

RUN git clone https://github.com/lungd/sibernetic.git && \
  chown -R $USER sibernetic && \
  cd sibernetic && \
  git checkout ow-0.1 && \
  make clean && make all

ENV JNML_HOME=$HOME/jNeuroML
ENV PATH=$PATH:$JNML_HOME
ENV IV=$HOME/neuron/iv
ENV N=$HOME/neuron/nrn
ENV CPU=x86_64
ENV PATH=$PATH:$IV/$CPU/bin:$N/$CPU/bin
ENV NEURON_HOME=$N/$CPU
ENV C302_HOME=$HOME/CElegansNeuroML/CElegans/pythonScripts/c302
ENV SIBERNETIC_HOME=$HOME/sibernetic
ENV PYTHONPATH=$PYTHONPATH:$C302_HOME:$SIBERNETIC_HOME

