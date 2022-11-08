FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu18.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  git \
  python3.10
  
RUN which python3

# set python3.10 as default
RUN update-alternatives --install /usr/local/bin/python3 python3 /usr/local/bin/python3.10 1

RUN python3 -m pip install --upgrade pip

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

WORKDIR /stable-diffusion-webui

RUN python3 -c "from launch import prepare_environment; prepare_environment()"
