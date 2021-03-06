NUM_ZK=$1

echo "Generating ./zookeeper-3.4.14/zookeeper-statefulset-generated.yaml with NUM_ZK $NUM_ZK."

cat <<EOF > ./zookeeper-3.4.14/zookeeper-statefulset-generated.yaml
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: zookeeper
  namespace: kafka
spec:
  selector:
    matchLabels:
      app: zookeeper
  serviceName: zookeeper-service
  replicas: $NUM_ZK
  template:
    metadata:
      labels:
        app: zookeeper
      annotations:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: zk-node 
                operator: In
                values: ["true"]
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                  - key: app
                    operator: In
                    values: ["zookeeper"]
              topologyKey: "kubernetes.io/hostname"
      initContainers:
      - name: init-config
        image: nichemley/fs-kafka-config-image 
        command: ['/bin/bash', '/etc/zookeeper-config-ro/generate-config.sh']
        volumeMounts:
        - name: zookeeper-config-ro 
          mountPath: /etc/zookeeper-config-ro
        - name: zookeeper-config-rw 
          mountPath: /etc/zookeeper-config-rw
        - name: data 
          mountPath: /data
      containers:
      - name: zookeeper
        image: wurstmeister/kafka 
        command: ["/opt/kafka/bin/zookeeper-server-start.sh"]
        args: ["/etc/zookeeper-config-rw/zookeeper.properties"]
        ports:
        - containerPort: 2181
          name: client
        - containerPort: 2888
          name: peer
        - containerPort: 3888
          name: leader-election
        resources:
          requests:
            memory: 100Mi
        volumeMounts:
        - name: zookeeper-config-rw
          mountPath: /etc/zookeeper-config-rw
        - name: data 
          mountPath: /data
        - name: datalog
          mountPath: /datalog
      volumes:
      - name: zookeeper-config-ro 
        configMap:
          name: zookeeper-config
      - name: zookeeper-config-rw 
        emptyDir: {}
      tolerations:
      - key: "is-kafka-broker-node"
        operator: "Exists"
        effect: "NoSchedule"
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: 10Gi
    - metadata:
        name: datalog
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: 10Gi
EOF
