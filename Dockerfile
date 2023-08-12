# 使用指定基础镜像
FROM registry.cn-beijing.aliyuncs.com/pai-dlc/pytorch-training:1.12-gpu-py39-cu113-ubuntu20.04

# 设置工作目录
WORKDIR /

# 复制本地路径到工作目录
COPY so-vits-svc /

# 切换到子目录
WORKDIR so-vits-svc

# 安装 PyTorch 和其他依赖
RUN conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=11.3 -c pytorch  -y
RUN pip install -r requirements.txt
RUN wget -P so-vits-svc/pretrain/ https://bj-vits.oss-cn-beijing-internal.aliyuncs.com/checkpoint_best_legacy_500.pt -O so-vits-svc/pretrain/checkpoint_best_legacy_500.pt && \
    wget -P so-vits-svc/logs/44k/ https://bj-vits.oss-cn-beijing-internal.aliyuncs.com/G_0.pth && \
    wget -P so-vits-svc/logs/44k/ https://bj-vits.oss-cn-beijing-internal.aliyuncs.com/D_0.pth && \
    wget -P so-vits-svc/logs/44k/diffusion/ https://bj-vits.oss-cn-beijing-internal.aliyuncs.com/moudel_0.pth && \
    wget -P so-vits-svc/pretrain/ https://bj-vits.oss-cn-beijing-internal.aliyuncs.com/nsf-hifigan.zip && \
    unzip -od so-vits-svc/pretrain/nsf_hifigan so-vits-svc/pretrain/nsf_hifigan.zip && \
    wget -P so-vits-svc/configs_template/ https://bj-vits.oss-cn-beijing-internal.aliyuncs.com/config_template.json -O so-vits-svc/configs_template/config_template.json && \
    wget -P so-vits-svc/configs_template/ https://bj-vits.oss-cn-beijing-internal.aliyuncs.com/diffusion_template.yaml -O so-vits-svc/configs_template/diffusion_template.yaml
