 
 # installation

  apt install -y software-properties-common
 apt install -y build-essential
 apt install -y libssl-dev zlib1g-dev libncurses5-dev libnss3-dev libreadline-dev libffi-dev curl libsqlite3-dev wget

add-apt-repository ppa:deadsnakes/ppa
apt update

apt install python3.10

apt install python3.10-distutils -y
apt install python3-pip -y

apt install curl -y

apt remove python3-pip -y
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.10 get-pip.py


git clone https://github.com/huggingface/alignment-handbook.git
cd ./alignment-handbook/
python -m pip install .


python -m pip install flash-attn --no-build-isolation

pip install huggingface_hub==0.24.4
 
# Docker
 
 docker build -t alignment-handbook .

 # RUN

docker run --gpus all -v /mnt/s.kochetkov:/workspace --name sergey_alignment_handbook -d -t docker-hosted.
artifactory.tcsbank.ru/biglm/alignment-handbook

docker run --gpus all --name sergey_alignment_handbook -d -t docker-hosted.artifactory.tcsbank.ru/biglm/alignment-handbook

cd /workspace/alignment-handbook

cd /alignment-handbook
 ACCELERATE_LOG_LEVEL=info accelerate launch --config_file recipes/accelerate_configs/multi_gpu.yaml --num_processes=1 scripts/run_sft.py recipes/zephyr-7b-beta/sft/config_qlora.yaml --load_in_4bit=true

CUDA_VISIBLE_DEVICES=2 ; ACCELERATE_LOG_LEVEL=info accelerate launch --config_file recipes/accelerate_configs/multi_gpu.yaml --num_processes=1 scripts/run_dpo.py recipes/zephyr-7b-beta/dpo/config_qlora.yaml