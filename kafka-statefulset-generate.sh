#!/bin/bash

NUM_PARTITIONS=$1

cat <<EOF > ./kafka/kafka-statefulset-generated.yaml
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
      initContainers:
        - name: init-config
          image: nichemley/fs-kafka-config-image 
          env:
            - name: NODE_NAME
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
            - name: NUM_PARTITIONS
              value: $NUM_PARTITIONS 
          command: ['/bin/bash', '/etc/kafka-config-ro/generate-config.sh']
          volumeMounts:
          - name: kafka-config-volume-ro
            mountPath: /etc/kafka-config-ro
          - name: kafka-config-volume-rw
            mountPath: /etc/kafka-config-rw
      containers:
        - name: kafka
          image: wurstmeister/kafka
          ports:
            - containerPort: 9092
          command:
            - /opt/kafka/bin/kafka-server-start.sh
            - /etc/kafka-config-rw/server.properties
          env:
            - name: JMX_PORT
              value: "5555"
          volumeMounts:
            - name: kafka-config-volume-ro
              mountPath: /etc/kafka-config-ro
            - name: kafka-config-volume-rw
              mountPath: /etc/kafka-config-rw
            - name: data
              mountPath: /var/lib/kafka
          resources:
            requests:
              memory: "8Gi"
      volumes:
        - name: kafka-config-volume-ro
          configMap:
            name: kafka-config
        - name: kafka-config-volume-rw
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
EOF
