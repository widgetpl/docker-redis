# REDIS cluster for Kubernetes use


~~~~
apiVersion: v1
kind: ReplicationController
metadata:
  name: redis-node-101
  labels:
    app: redis
    cluster-id: redis-cluster-001
    node-id: node-101

spec:
  replicas: 1
  selector:
    app: redis
    cluster-id: redis-cluster-001
    node-id: node-101

  template:
    metadata:
      labels:
        app: redis
        cluster-id: redis-cluster-001
        node-id: node-101
    spec:
      nodeSelector:
        zone: "be-prod"
      containers:

      - name: redis-node-101
        image: widgetpl/rediscluster:0.9
        imagePullPolicy: IfNotPresent
        command: ["/custom-entrypoint.sh"]
        args:
          - "redis-server"
          - "--appendonly no"
          - "--cluster-enabled yes"
          - "--port 6379"
          - "--cluster-node-timeout 1000"
          - "--cluster-require-full-coverage yes"

        env:
        - name: "CLUSTER_CONFIG"
          value: |
            redis-cluster-dev---------redis-node-101 ${REDIS_001_NODE_101_SERVICE_HOST}:${REDIS_001_NODE_101_SERVICE_PORT} myself,master - 0 0 0 connected 0-5460
            redis-cluster-dev---------redis-node-102 ${REDIS_001_NODE_102_SERVICE_HOST}:${REDIS_001_NODE_102_SERVICE_PORT} slave - 0 0 0 connected
            redis-cluster-dev---------redis-node-201 ${REDIS_001_NODE_201_SERVICE_HOST}:${REDIS_001_NODE_201_SERVICE_PORT} slave - 0 0 0 connected
            redis-cluster-dev---------redis-node-202 ${REDIS_001_NODE_202_SERVICE_HOST}:${REDIS_001_NODE_202_SERVICE_PORT} slave - 0 0 0 connected
            redis-cluster-dev---------redis-node-301 ${REDIS_001_NODE_301_SERVICE_HOST}:${REDIS_001_NODE_301_SERVICE_PORT} slave - 0 0 0 connected
            redis-cluster-dev---------redis-node-302 ${REDIS_001_NODE_302_SERVICE_HOST}:${REDIS_001_NODE_302_SERVICE_PORT} slave - 0 0 0 connected
            vars currentEpoch 0 lastVoteEpoch 0

        ports:
        - name: redis1-port
          containerPort: 6379
          protocol: TCP
        - name: redis1-cluster
          containerPort: 16379
          protocol: TCP
        resources:
          limits:
            cpu: 100m
            memory: 512Mi
        livenessProbe:
          tcpSocket:
            port: 6379
          initialDelaySeconds: 30
          timeoutSeconds: 5
~~~~
