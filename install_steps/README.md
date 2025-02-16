# Guia de Preparação para Instalação do Kubernetes

## Introdução

Este guia contém as instruções necessárias para preparar o sistema operacional **Oracle Linux 9** antes da instalação do Kubernetes utilizando o Kubespray. A correta configuração do ambiente garante uma instalação estável e segura.

## 📌 Passos de Preparação

1️⃣ **Instalar os pacotes necessários**  
   - Pacotes essenciais para o funcionamento do Kubernetes.
   - Ferramentas de automação e gerenciamento de dependências.

2️⃣ **Configurar o sistema operacional**  
   - Ajustes no SELinux e firewall para evitar conflitos com o Kubernetes.
   - Configurações do kernel para suporte ao tráfego de rede e roteamento correto.
   - Desativação do swap para garantir um gerenciamento eficiente da memória.

3️⃣ **Configurar acesso SSH**  
   - Gerar e distribuir chaves SSH para comunicação entre os nós.
   - Ajustar permissões e configurações para facilitar a instalação remota.

4️⃣ **Clonar o repositório Kubespray**  
   - Baixar os arquivos necessários para a instalação do cluster.
   - Estruturar o ambiente de deploy para execução dos scripts.

## 📥 Clonando o Kubespray
Antes de prosseguir com a instalação, clone o repositório oficial do Kubespray:

```sh
git clone https://github.com/kubespray/kubespray.git
```

Após isso, siga os passos documentados neste diretório para concluir a preparação do ambiente.

## 🔗 Próximos Passos
Após ler esse documento, siga para o [setup dos hosts](hosts_setup.md)

