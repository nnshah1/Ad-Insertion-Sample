include(platform.m4)

apiVersion: v1
kind: Service
metadata:
  name: ad-content-service
  labels:
    app: ad-content
spec:
  ports:
  - port: 8080
    protocol: TCP
  selector:
    app: ad-content

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: ad-content
  labels:
     app: ad-content
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ad-content
  template:
    metadata:
      labels:
        app: ad-content
    spec:
      enableServiceLinks: false
      containers:
        - name: ad-content
          image: defn(`REGISTRY_PREFIX')ssai_ad_content_frontend:latest
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: 8080
          env:
            - name: NO_PROXY
              value: "*"
            - name: no_proxy
              value: "*"
          volumeMounts:
            - mountPath: /var/www/archive
              name: ad-archive
              readOnly: true
      volumes:
          - name: ad-archive
            persistentVolumeClaim:
               claimName: ad-archive
PLATFORM_NODE_SELECTOR(`Xeon')dnl
