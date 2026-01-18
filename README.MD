## Lab 1
### ConfigMaps and Secrets

- Create a configmap and a secret.
- kubectl describe both resources.
- Secrets are base64 encoded when stringData used. (stringData vs data).
- Opaque tells K8s to not assume the format/type of data.
- `kubectl exec <pod_name> -- env`

### PersistentVolume (PV) & PersistentVolumeClaim (PVC)

- Pods and containers are ephemeral.
- PV is a disk that can exist before applications.
- Examples of PV: AWS EBS, Local Disk.
- Pod → uses → PVC → binds to → PV → Actual Disk
- `kubectl exec pv-pod -- cat /data/hello.txt`
- Delete the pod: `kubectl delete pod pv-pod`
- Recreate the pod and check again if the data persists.


### StatefulSets

- Most Kubernetes workloads are stateless.
- A simple example is how pods are created with random names.
- StatefulSets create predictable names like: web-01, web-02 pods.
- Each pod gets its own PVC and one pod cannot access another pod’s PVC unless specified (RWX).
- Used for Database solutions like MySQL, Postgres.
- Create pods in order: 0 → 1 → 2
- Delete pods in reverse order: 2 → 1 → 0
- Deleting a StatefulSet: Does NOT delete PVCs, Deletes pods

## Lab 2
### Service
- ClusterIP, NodePort and LoadBalancer
- Headless Service
- labels/selectors connect Pods to Services (Lab 1 StatefulSets)
- How does traffic reach a pod if pod IPs change?

### Ingress
- Ingress vs Service
- Ingress Controller
- Client → Ingress → Service → Pod
- minikube addons enable ingress

### Horizontal Pod Autoscaler (HPA)
- Scaling pods (not nodes) based on CPU/memory
- Metrics is needed first from metrics server or custom metrics
- `minikube addons enable metrics-server`
- Also explore `kubectl top`
- Why it needs resource requests (not limits)
- Overrides `replicas:` in deployments and replicaSets

### Rolling Updates
- strategy: RollingUpdate vs Recreate
- maxSurge, maxUnavailable:
- Both cannot be 0, at least one needs to progress.
- Is NOT Blue/Green or Canary Deployment strategies
- If maxUnavailable = 0, still zero downtime, but slower rollout.

## Lab 3
### DaemonSet
- `minikube status` after `minikube start`
- `kubectl get nodes` and `minikube node list`
- `minikube node add`
- Repeat Step 2.
- Alternately, `minikube delete` to delete cluster and `minikube start --nodes=3`
- `--nodes=3`, control plane is counted as one node here.
- `kubectl get daemonsets` and `kubectl describe`
- `kubectl get pods -o wide` used to display additional information like in which node a pod is running.
- `kubectl logs <pod-name>`

### Jobs and CronJobs
- Most Kubernetes workloads (Deployments, StatefulSets) are long-running.
- Jobs ensures a Pod runs to completion.
- Retries on failure, Can run: Once, Multiple times in parallel and Until 'N' successful completions
- CronJobs run using the kube-controller-manager timezone (not the Pod’s).