FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  git \
  ffmpeg libsm6 libxext6 \
  software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y --no-install-recommends \
  python3.10 \
  python3.10-distutils

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

ARG PIP_PREFER_BINARY=1 PIP_NO_CACHE_DIR=1
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3
RUN pip install --upgrade pip
RUN pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 --extra-index-url https://download.pytorch.org/whl/cu113

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

WORKDIR /stable-diffusion-webui

# mind the spelling mistake, originally in https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/launch.py
RUN python3 -c "from launch import prepare_enviroment; prepare_enviroment()" --skip-torch-cuda-test

EXPOSE 7860
