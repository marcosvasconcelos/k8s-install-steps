#!/bin/bash
set -e

SSH_KEY="$HOME/.ssh/id_rsa"

# Lista de nós do cluster (ajuste conforme necessário)
NODES=("192.168.1.10" "192.168.1.11" "192.168.1.12" "192.168.1.20" "192.168.1.21" "192.168.1.22")

echo "[INFO] Verificando se a chave SSH já existe..."
if [ ! -f "$SSH_KEY" ]; then
    echo "[INFO] Gerando nova chave SSH..."
    ssh-keygen -t rsa -b 4096 -N "" -f "$SSH_KEY"
else
    echo "[INFO] Chave SSH já existe em $SSH_KEY"
fi

echo "[INFO] Distribuindo a chave SSH para os nós..."
for NODE in "${NODES[@]}"; do
    echo "[INFO] Copiando chave para $NODE..."
    ssh-copy-id -i "$SSH_KEY.pub" root@"$NODE"
done

echo "[INFO] Testando conexão SSH..."
for NODE in "${NODES[@]}"; do
    ssh -o StrictHostKeyChecking=no root@"$NODE" "echo 'Conexão SSH bem-sucedida com $NODE'"
done

echo "[INFO] Configuração de SSH concluída com sucesso!"
