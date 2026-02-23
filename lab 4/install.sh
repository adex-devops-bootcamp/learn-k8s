helm install cluster-autoscaler autoscaler/cluster-autoscaler \
  -n kube-system \
  -f values.yaml