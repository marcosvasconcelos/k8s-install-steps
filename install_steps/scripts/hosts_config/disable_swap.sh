#!/bin/bash
set -e

echo "[INFO] Desativando Swap..."
sudo swapoff -a

echo "[INFO] Removendo entrada do Swap no fstab..."
sudo sed -i '/swap/d' /etc/fstab

echo "[INFO] Swap desativado com sucesso!"
