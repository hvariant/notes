# Kubernetes

## set up local cluster

[Reference](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)

Follow the instructions [here](https://github.com/hvariant/container.training/tree/update-prepare-local/prepare-local)
to spin up five VMs:

```
vagrant up
ansible-playbook provision.yml
```

then on node1:

- initialise control plane and set api server address
```
kubeadm init --apiserver-advertise-address=10.10.10.10
```

- setup kubectl
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

- install weave:
```
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

- set up [routing](https://stackoverflow.com/a/42896637):
```
route add 10.96.0.1 gw 10.10.10.10
```

- join from other nodes:
```
kubeadm join 10.10.10.10:<control-plane-port> --token <token> \
        --discovery-token-ca-cert-hash sha256:<hash>
```

## access cluster ip from outside minikube

```
# local port 8888 -> pod 80
kubectl port-forward --address localhost pod/hasher-ccc9f44ff-f46nm 8888:80
```
