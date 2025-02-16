# Implantação do Kubernetes com Kubespray

## 1️⃣ Configurar o Inventário

Para iniciar a instalação do Kubernetes, primeiro entre no diretório do Kubespray e copie o inventário padrão para um diretório personalizado:

```sh
cd kubespray
cp -rfp inventory/sample inventory/cluster_name
```



Para iniciar a instalação do Kubernetes, é necessário criar um arquivo de inventário personalizado. Utilize o modelo `hosts.yaml` abaixo e ajuste os nomes dos hosts conforme o ambiente.

### 📌 Exemplo de `hosts.yaml`
```yaml
all:
  hosts:
    master1:
      ansible_host: 10.10.1.3
    master2:
      ansible_host: 10.10.1.4
    master3:
      ansible_host: 10.10.1.5
    worker1:
      ansible_host: 10.10.1.6
    worker2:
      ansible_host: 10.10.1.7
    worker3:
      ansible_host: 10.10.1.8
  children:
    kube_control_plane:
      hosts:
        master1:
        master2:
        master3:
    etcd:
      hosts:
        master1:
        master2:
        master3:
    kube_node:
      hosts:
        worker1:
        worker2:
        worker3:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
```

### 🔧 Ajustes Necessários
- **O arquivo `hosts.yaml` deve estar localizado em:** `inventory/cluster_name/hosts.yaml`.
- **Substitua os nomes dos hosts** caso sua infraestrutura utilize identificadores diferentes.
- **Atualize os endereços IP** para corresponderem aos seus servidores reais.
- Certifique-se de que os nós estão acessíveis via SSH.
- **Substitua os nomes dos hosts** caso sua infraestrutura utilize identificadores diferentes.
- **Atualize os endereços IP** para corresponderem aos seus servidores reais.
- Certifique-se de que os nós estão acessíveis via SSH.

Salve este arquivo como `inventory/cluster_name/hosts.yaml` e prossiga com a instalação.

## 2️⃣ Revisar Configuração

Antes de executar a instalação, é necessário ajustar algumas configurações para garantir que o cluster esteja corretamente configurado.

### 🔧 Ajustes Obrigatórios
- **Habilitar o Metrics Server** e configurar a porta para `4443`, ativando o bypass do SSL. Essas configurações estão no arquivo `inventory/cluster_name/group_vars/k8s_cluster/addons.yml`.
- **Habilitar o Helm** para facilitar a instalação de pacotes no cluster. Também configurado em `addons.yml`.
- **Configurar o Ingress NGINX** para rodar com `3 réplicas`, garantindo alta disponibilidade. Ajuste no `addons.yml`.
- **Verificar a versão do Kubernetes** definida em `inventory/cluster_name/group_vars/k8s_cluster/k8s-cluster.yml`. Essa versão pode ser alterada conforme necessidade, mas a versão suportada pelo Kubespray geralmente é suficiente para a instalação do **Rancher**, que será realizada em uma etapa posterior.

Antes de executar a instalação, é necessário ajustar algumas configurações para garantir que o cluster esteja corretamente configurado.

### 🔧 Ajustes Obrigatórios
- **Habilitar o Metrics Server** e configurar a porta para `4443`, ativando o bypass do SSL.
- **Habilitar o Helm** para facilitar a instalação de pacotes no cluster.
- **Configurar o Ingress NGINX** para rodar com `3 réplicas`, garantindo alta disponibilidade.

### 📌 Como Revisar e Modificar as Configurações
Revise os parâmetros do cluster e faça ajustes conforme necessário nos seguintes arquivos:

```sh
cat inventory/cluster_name/group_vars/all/all.yml
cat inventory/cluster_name/group_vars/k8s_cluster/k8s-cluster.yml
cat inventory/cluster_name/group_vars/k8s_cluster/addons.yml
```

Dentro desses arquivos, modifique os seguintes parâmetros conforme necessário:
Revise os parâmetros do cluster e faça ajustes conforme necessário nos seguintes arquivos:

```sh
cat inventory/cluster_name/group_vars/all/all.yml
cat inventory/cluster_name/group_vars/k8s_cluster/k8s-cluster.yml
```

Dentro desses arquivos, modifique os seguintes parâmetros:

#### Habilitar o Metrics Server e ajustar a porta (`addons.yml`)
```yaml
metrics_server_enabled: true
metrics_server_secure_port: 4443
metrics_server_skip_tls_verify: true
```

#### Habilitar o Helm (`addons.yml`)
```yaml
helm_enabled: true
```

#### Configurar o Ingress NGINX com 3 réplicas (`addons.yml`)
```yaml
ingress_nginx_enabled: true
ingress_nginx_replica_count: 3
```

Após realizar essas configurações, prossiga com a instalação.

Revise os parâmetros do cluster e faça ajustes conforme necessário:

```sh
cat inventory/cluster_name/group_vars/all/all.yml
cat inventory/cluster_name/group_vars/k8s_cluster/k8s-cluster.yml
```

Modifique esses arquivos conforme necessário para adequar a configuração ao seu ambiente.

## 3️⃣ Resetar Cluster (Opcional)

Caso o cluster já tenha sido instalado anteriormente e precise ser resetado, execute um dos seguintes comandos:

### 📌 Se estiver usando a chave SSH como root:
```sh
ansible-playbook -i inventory/cluster_name/hosts.yaml --become --become-user=root reset.yml
```

### 📌 Se estiver usando um usuário sem privilégios root:
O usuário deve ter permissões de `sudo` configuradas para executar comandos como root. Use o seguinte comando:
```sh
ansible-playbook -i inventory/cluster_name/hosts.yaml --become --ask-become-pass reset.yml
```

⚠️ **Atenção:** Esse comando removerá completamente a instalação existente do Kubernetes, incluindo certificados, pacotes e configurações.

Caso o cluster já tenha sido instalado anteriormente e precise ser resetado, execute o seguinte comando:

```sh
ansible-playbook -i inventory/cluster_name/hosts.yaml --become --become-user=root reset.yml
```

⚠️ **Atenção:** Esse comando removerá completamente a instalação existente do Kubernetes, incluindo certificados, pacotes e configurações.

## 4️⃣ Implantar o Cluster Kubernetes

Agora, execute o playbook principal para instalar o Kubernetes com o Kubespray.

### 📌 Se estiver usando a chave SSH como root:
```sh
ansible-playbook -i inventory/cluster_name/hosts.yaml --become --become-user=root cluster.yml
```

### 📌 Se estiver usando um usuário sem privilégios root:
O usuário deve ter permissões de `sudo` configuradas. Use o seguinte comando:
```sh
ansible-playbook -i inventory/cluster_name/hosts.yaml --become --ask-become-pass cluster.yml
```

Esse processo pode levar alguns minutos, dependendo da infraestrutura. Após a execução bem-sucedida, seu cluster Kubernetes estará pronto para uso.

Agora, execute o playbook principal para instalar o Kubernetes com o Kubespray:

```sh
ansible-playbook -i inventory/cluster_name/hosts.yaml --become --become-user=root cluster.yml
```

Esse processo pode levar alguns minutos, dependendo da infraestrutura. Após a execução bem-sucedida, seu cluster Kubernetes estará pronto para uso.

## 🔗 Próximos Passos

Após a instalação, configure o acesso ao cluster com `kubectl`, configure o Ingress Controller, monitore os nós e implemente workloads no Kubernetes.

### 📌 Realizar Rollout no Calico
Após a instalação, recomenda-se executar um rollout no **DaemonSet do Calico** e no **Deployment do Calico Typha** para garantir que as configurações estejam corretamente aplicadas.

```sh
kubectl rollout restart daemonset -n kube-system calico-node
kubectl rollout restart deployment -n kube-system calico-typha
```

Isso garantirá que todas as instâncias do Calico sejam recarregadas com as novas configurações aplicadas durante a instalação.

Após a instalação, configure o acesso ao cluster com `kubectl`, configure o Ingress Controller, monitore os nós e implemente workloads no Kubernetes.

