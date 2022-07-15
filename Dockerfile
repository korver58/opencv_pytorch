ARG BASE_IMAGE=pytorch/pytorch:1.12.0-cuda11.3-cudnn8-devel
FROM ${BASE_IMAGE}

ARG UID=1000
ARG USER=developer
RUN useradd -m -u ${UID} ${USER}
ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/home/${USER}
WORKDIR ${HOME}

RUN apt-get update && apt-get install -y \
    curl wget git build-essential \
    python3-dev python3-pip \
    # opencv
    libgl1-mesa-dev \
    python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${USER}
RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install setuptools wheel
COPY --chown=${USER} ./yolov5/requirements.txt requirements.txt
RUN python3 -m pip install -r requirements.txt \
    && python3 -m pip install opencv-python tqdm pygame matplotlib open3d

CMD ["/bin/bash"]