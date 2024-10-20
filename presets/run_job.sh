

COMMAND_TO_EXECUTE_FROM_JOB='cd /alignment-handbook && ACCELERATE_LOG_LEVEL=info && accelerate launch --config_file recipes/accelerate_configs/multi_gpu.yaml --num_processes=1 scripts/run_sft.py recipes/llama3-8b/sft/config_qlora.yaml --load_in_4bit=true'


IMAGE_NAME=docker-hosted.artifactory.tcsbank.ru/biglm/alignment-handbook 

mlc job submit -p biglm --region ix-m4-sm4 --flavor a100-1x \
 --output type=files,name=tutorial_dpo,src=/alignment-handbook/data \
 --generate-name=alignment-dpo-tutorial --time-limit=20h $IMAGE_NAME -- bash -c "$COMMAND_TO_EXECUTE_FROM_JOB"
