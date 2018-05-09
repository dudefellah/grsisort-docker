FROM ubuntu:17.10 as root

ARG ROOT_VERSION=v6.12.06

RUN apt-get update && apt-get -y install wget
RUN wget -O /tmp/root_${ROOT_VERSION}.Linux-ubuntu17-x86_64-gcc7.2.tar.gz https://root.cern.ch/download/root_${ROOT_VERSION}.Linux-ubuntu17-x86_64-gcc7.2.tar.gz && \
    tar -C /opt -vxzf /tmp/root_${ROOT_VERSION}.Linux-ubuntu17-x86_64-gcc7.2.tar.gz

FROM root as grsisort

RUN apt-get -y install git bash

SHELL ["/bin/bash", "-c"]

ARG GRSISORT_VERSION=v3.1.3.4

ENV PATH="${PATH}:/opt/root/bin"

COPY files/etc/ld.so.conf.d/root.conf /etc/ld.so.conf.d/root.conf

RUN ldconfig && \
    apt-get -y install build-essential coreutils g++ libblas3 libpython2.7 libtbb2 libx11-dev libxml2 libxpm-dev && \
    git clone https://github.com/GRIFFINCollaboration/GRSISort.git /tmp/grsisort && \
    cd /tmp/grsisort && \
    git checkout ${GRSISORT_VERSION} && \
    cd /tmp/grsisort && \
    source /tmp/grsisort/thisgrsi.sh && \
    make -j && \
    install -m 0755 /tmp/grsisort/bin/* /usr/local/bin/
