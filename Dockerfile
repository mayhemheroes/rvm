FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential

ADD . /rvm
WORKDIR /rvm
RUN gcc -std=gnu99 vm.c -o vm
RUN gcc -std=gnu99 asm.c -o asm
RUN gcc -std=gnu99 rcc.c -o rcc

RUN mkdir -p /deps
RUN ldd /rvm/rcc | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04 as package

COPY --from=builder /deps /deps
COPY --from=builder /rvm/rcc /rvm/rcc
ENV LD_LIBRARY_PATH=/deps
