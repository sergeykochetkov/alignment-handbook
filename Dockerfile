FROM huggingface/transformers-pytorch-gpu:latest

# Update and install prerequisites
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.10 python3.10-dev python3.10-distutils curl git

# Set python3.10 as the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Install pip for Python 3.10
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.10 get-pip.py && \
    rm get-pip.py

# Clone the alignment-handbook repository and install it
RUN git clone https://github.com/sergeykochetkov/alignment-handbook.git && \
    cd alignment-handbook && \
    python3 -m pip install .

# Install additional dependencies

RUN python3 -m pip install --upgrade huggingface_hub

RUN git clone https://github.com/Dao-AILab/flash-attention.git
RUN cd flash-attention && git checkout v2.6.3 && python3 setup.py install
