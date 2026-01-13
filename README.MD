## ConfigMaps and Secrets

- Create a configmap and a secret.
- kubectl describe both resources.
- Secrets are base64 encoded when stringData used. (stringData vs data).
- Opaque tells K8s to not assume the format/type of data.
- kubectl exec -ti <pod_name> env vs <pod_name> -- env

## PersistentVolume (PV) & PersistentVolumeClaim (PVC)

- Pods and containers are ephemeral.
- PV is a disk that can exist before applications.
- Examples of PV: AWS EBS, Local Disk.
- Pod → uses → PVC → binds to → PV → Actual Disk
- kubectl exec pv-pod -- cat /data/hello.txt
- Delete the pod: kubectl delete pod pv-pod
- Recreate the pod and check again if the data persists.


## StatefulSets

- Most Kubernetes workloads are stateless.
- A simple example is how pods are created with random names.
- StatefulSets create predictable names like: web-01, web-02 pods.
- Each pod gets its own PVC and one pod cannot access another pod’s PVC unless specified (RWX).
- Used for Database solutions like MySQL, Postgres.
- Create pods in order: 0 → 1 → 2
- Delete pods in reverse order: 2 → 1 → 0
- Deleting a StatefulSet: Does NOT delete PVCs, Deletes pods
