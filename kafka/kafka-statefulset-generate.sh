#!/bin/bash

NUM_PARTITIONS=$1
REPLICATION_FACTOR=$2

echo "Generating ./kafka/kafka-statefulset-generated.yaml with NUM_PARTITIONS $NUM_PARTITIONS REPLICATION_FACTOR $REPLICATION_FACTOR."

cat <<EOF > ./kafka/kafka-statefulset-generated.yaml
---
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: kafka
  namespace: kafka
  labels:
    app: kafka
spec:
  serviceName: kafka-service
  replicas: 0
  selector:
    matchLabels:
      app: kafka
  template:
    metadata:
      labels:
        app: kafka
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: kafka-broker-node
                    operator: In
                    values: ["true"]
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                  - key: app
                    operator: In
                    values: ["kafka", "zookeeper"]
              topologyKey: "kubernetes.io/hostname"
      initContainers:
        - name: init-config
          image: nichemley/fs-kafka-config-image
          env:
            - name: NODE_NAME
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
            - name: NUM_PARTITIONS
              value: "$NUM_PARTITIONS" 
            - name: REPLICATION_FACTOR 
              value: "$REPLICATION_FACTOR" 
          command: ['/bin/bash', '/etc/kafka-config-ro/generate-config.sh']
          volumeMounts:
            - name: kafka-config-volume-ro
              mountPath: /etc/kafka-config-ro
            - name: kafka-config-volume-rw
              mountPath: /etc/kafka-config-rw
        # sysctl settings (kernel parameters)
        - name: init-sysctl
          image: busybox
          command:
            - sh 
            - -c
            - sysctl -w vm.swappiness=1; sysctl -w vm.dirty_ratio=60; sysctl -w vm.dirty_background_ratio=5; sysctl -w net.ipv4.tcp_max_syn_backlog=1024; sysctl -w net.ipv4.tcp_max_tw_buckets=262144
            # sysctl -w net.ipv4.tcp_rmem='4096 87380 33554432'; sysctl -w net.ipv4.tcp_wmem='4096 65536 33554432'
          securityContext:
            privileged: true
      containers:
        - name: kafka
          # image: wurstmeister/kafka
          # image containing javaagent/jmx exporter
          image: nichemley/fs-kafka-image
          ports:
            - containerPort: 9092
          command:
            - /opt/kafka/bin/kafka-server-start.sh
            - /etc/kafka-config-rw/server.properties
          env:
            - name: JMX_PORT
              value: "5555"
            # Keep heap size small, save rest for page cache - https://www.slideshare.net/ToddPalino/kafka-at-peak-performance
            - name: KAFKA_HEAP_OPTS
              value: "-Xmx6g -Xms6g"
            - name: KAFKA_JVM_PERFORMANCE_OPTS

              # these are the defaults in kafka-run-class.sh
              # value: "-server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:+ExplicitGCInvokesConcurrent -XX:MaxInlineLevel=15 -Djava.awt.headless=true"

              value: "-server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:+ExplicitGCInvokesConcurrent -XX:MaxInlineLevel=15 -XX:MetaspaceSize=96M -XX:G1HeapRegionSize=16M -XX:MinMetaspaceFreeRatio=50 -XX:MaxMetaspaceFreeRatio=80 -Djava.awt.headless=true"

              # other values of interest
              # value: "-XX:ParallelGCThreads=20 -XX:ConcGCThreads=5"
            # JMX Exporter Java agent
            # Note - exposes /metrics on port 7071
            - name: KAFKA_OPTS
              value: -javaagent:/usr/app/jmx_prometheus_javaagent.jar=7071:/usr/app/prom-jmx-agent-config.yml
          volumeMounts:
            - name: kafka-config-volume-ro
              mountPath: /etc/kafka-config-ro
            - name: kafka-config-volume-rw
              mountPath: /etc/kafka-config-rw
            - name: data
              mountPath: /var/lib/kafka
          resources:
            requests:
              memory: "21Gi"
            limits:
              memory: "21Gi"
      volumes:
        - name: kafka-config-volume-ro
          configMap:
            name: kafka-config
        - name: kafka-config-volume-rw
          emptyDir: {}
  # tolerations:
  #  - key: "is-kafka-broker-node"
  #    operator: "Exists"
  #    effect: "NoSchedule"
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: 100Gi
EOF
