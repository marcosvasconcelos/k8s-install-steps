# Configuração do Ambiente para Kubernetes

## 1️⃣ Instalar os Pacotes Necessários
### Esse passo deve ser executado para todos os hosts

Execute os comandos abaixo para instalar os pacotes essenciais no **Oracle Linux 9**:

```sh
sudo dnf update -y
sudo dnf install -y git python3 python3-pip
```

## 2️⃣ Configurar o Sistema Operacional

### Desativar o SELinux temporariamente:
```sh
sudo setenforce 0
```

### Desativar o SELinux permanentemente:
```sh
sudo sed -i 's/^SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
```

### Desativar o Firewalld:
```sh
sudo systemctl disable --now firewalld
```

### Desativar o Swap:
```sh
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab
```

### Configurar os Módulos do Kernel:
```sh
sudo tee /etc/modules-load.d/k8s.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
```

## 3️⃣ Configurar o Acesso SSH

### Gerar a chave SSH:
```sh
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
```

### Copiar a chave SSH para os nós do cluster:
```sh
for NODE in master1 master2 master3 worker1 worker2 worker3; do
    ssh-copy-id -i ~/.ssh/id_rsa.pub root@$NODE
done
```

## 4️⃣ Clonar o Repositório Kubespray

Baixe o repositório oficial do Kubespray:
```sh
git clone https://github.com/kubespray/kubespray.git
```

Agora o ambiente está preparado para iniciar a instalação do Kubernetes. Certifique-se de que todas as etapas foram concluídas antes de prosseguir para a configuração do cluster.

