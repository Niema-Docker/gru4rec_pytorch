# Minimal Docker image for GRU4Rec's official PyTorch implementation using PyTorch base
FROM pytorch/pytorch:2.9.1-cuda13.0-cudnn9-runtime
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# install GRU4Rec's official PyTorch implementation
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y git && \
    pip install --no-cache-dir --upgrade joblib pandas pip && \
    git clone https://github.com/hidasib/GRU4Rec_PyTorch_Official.git && \
    mv GRU4Rec_PyTorch_Official /usr/local/bin/GRU4Rec_PyTorch_Official && \
    #sed -i '/dtype/! s/torch\.tensor(/torch.tensor(dtype=torch.float32, data=/g' /usr/local/bin/GRU4Rec_PyTorch_Official/gru4rec_pytorch.py && \
    echo "alias gru4rec_run='python /usr/local/bin/GRU4Rec_PyTorch_Official/run.py'" >> ~/.bashrc && \
    echo "alias gru4rec_paropt='python /usr/local/bin/GRU4Rec_PyTorch_Official/paropt.py'" >> ~/.bashrc && \
    echo "alias gru4rec_tf='python /usr/local/bin/GRU4Rec_PyTorch_Official/gru4rec_tf.py'" >> ~/.bashrc && \
    rm -rf /root/.cache /tmp/*
