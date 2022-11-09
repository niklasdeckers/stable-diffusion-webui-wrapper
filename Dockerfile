FROM python:3.10-slim

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  git

ARG PIP_PREFER_BINARY=1 PIP_NO_CACHE_DIR=1
RUN python3 -m pip install --upgrade pip

RUN pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 --extra-index-url https://download.pytorch.org/whl/cu113

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

WORKDIR /stable-diffusion-webui

RUN python3 -c "from launch import prepare_environment; prepare_environment()"
