#!/bin/bash
set -e

echo "[INFO] Desativando Firewalld..."
sudo systemctl disable --now firewalld

echo "[INFO] Firewalld desativado com sucesso!"
