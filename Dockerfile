# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim less man wget tar git gzip unzip make cmake software-properties-common curl

ADD . /rvm
WORKDIR /rvm
RUN gcc -std=gnu99 vm.c -o vm
RUN gcc -std=gnu99 asm.c -o asm
RUN gcc -std=gnu99 rcc.c -o rcc
