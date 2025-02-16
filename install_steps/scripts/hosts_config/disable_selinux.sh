#!/bin/bash
set -e

echo "[INFO] Desativando SELinux temporariamente..."
sudo setenforce 0

echo "[INFO] Desativando SELinux permanentemente..."
sudo sed -i 's/^SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

echo "[INFO] SELinux desativado com sucesso!"
