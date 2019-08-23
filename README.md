### Bloomberg Big Data and NoSQL Platform
#### 1. Build Hadoop distro of version 2.7.3
#### 2. Build docker image 
```
docker build -t hadoop-base:latest -f Dockerfile .
```
Push the image to your repository unless using a local cluster.

#### 3. Minikube setup

If you are using minikube, create the paths:
`/tmp/nn` and `/tmp/keytab` on your host machine.

#### 4. Start PVCs
```
helm install -n hdfs-pvs pv --namespace bigdata
```
#### 5. Start Pods

a. KDC Node
```
helm install -n hdfs-kdc kdc --namespace bigdata
```
b. NN Node
```
helm install -n hdfs-nn namenode --namespace bigdata
```

c. DN Node
```
helm install -n hdfs-dn datanode --namespace bigdata
```

d. DataPopulator Node
```
helm install -n hdfs-dp datapopulator --namespace bigdata
```

#### 6. Run kinit in any node
```
kubectl exec  --namespace bigdata  -it $(kubectl get pods --namespace=bigdata | tail -1 | awk '{print $1}')  -- /bin/bash
su hdfs
kinit -kt /var/keytabs/hdfs.keytab hdfs/nn.bigdata.svc.cluster.local
hdfs dfs -ls /
```
