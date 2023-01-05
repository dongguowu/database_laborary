apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2022-10-29T21:26:25Z"
  generateName: nginx-6c98476dc8-
  labels:
    app: nginx
    pod-template-hash: 6c98476dc8
    type: front-end
  name: nginx-6c98476dc8-q2qtf
  namespace: nginx
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: nginx-6c98476dc8
    uid: 78971643-5b8c-4ab2-8a8c-b09fff6b3f18
  resourceVersion: "31471"
  uid: fad4a3cb-9161-414b-a074-1cfa5d35e4ea
spec:
  containers:
  - image: nginx:1.22.1
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 3
      httpGet:
        path: /
        port: 80
        scheme: HTTP
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 1
    name: nginx
    ports:
    - containerPort: 80
      protocol: TCP
    readinessProbe:
      failureThreshold: 3
      httpGet:
        path: /
        port: 80
        scheme: HTTP
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 1
    resources:
      limits:
        cpu: "5"
        memory: 500Mi
      requests:
        cpu: 250m
        memory: 120Mi
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-zqnlp
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: oracle-02
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-zqnlp
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2022-10-29T21:26:25Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2022-10-29T21:26:29Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2022-10-29T21:26:29Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2022-10-29T21:26:25Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://57f027a772bcde8ef33951f6d898a7f41f97743466857e5b9dbf2bc92378c9d9
    image: docker.io/library/nginx:1.22.1
    imageID: docker.io/library/nginx@sha256:fdf01cd582b3ef270f1efde2de57a3eb1e9694668f18c1e53183bc2ea2643574
    lastState: {}
    name: nginx
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2022-10-29T21:26:28Z"
  hostIP: 10.0.0.71
  phase: Running
  podIP: 10.42.1.11
  podIPs:
  - ip: 10.42.1.11
  qosClass: Burstable
  startTime: "2022-10-29T21:26:25Z"
