FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /ei

# Install base dependencies
RUN apt update && apt install -y build-essential software-properties-common wget

# Install LLVM 9
RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh 9
RUN rm /usr/bin/gcc && rm /usr/bin/g++ && ln -s $(which clang-9) /usr/bin/gcc && ln -s $(which clang++-9) /usr/bin/g++

# Install Python 3.8
RUN apt install -y python3

# Copy the base application in
COPY app ./app

# Copy any scripts in that we have
COPY *.py ./

# This is the script our application should run (-u to disable buffering)
ENTRYPOINT [ "python3", "-u", "build.py" ]