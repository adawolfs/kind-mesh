# KinD


## Installation

### Docker
```
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo"
yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin firewalld"
```

### KinD

```
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/sbin/kind
```

### Kubectl

```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/sbin/kubectl
```