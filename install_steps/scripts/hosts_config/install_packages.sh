#!/bin/bash
set -e

echo "[INFO] Atualizando pacotes..."
sudo dnf update -y

echo "[INFO] Instalando pacotes essenciais..."
sudo dnf install -y git python3 python3-pip \
    python3-devel gcc libffi-devel openssl-devel \
    curl iproute-tc bash-completion \
    conntrack-tools socat

echo "[INFO] Pacotes instalados com sucesso!"
