# Egress is blocked hence this command will fail
kubectl exec $(kubectl get pod -n curl -l app=curl -o jsonpath='{.items..metadata.name}') -n curl -c curl -- curl -sI http://httpbin.org:80/get

# Egress policy to grant access to httpbin.org
kubectl apply -f - <<EOF
kind: Egress
apiVersion: policy.openservicemesh.io/v1alpha1
metadata:
  name: httpbin-80
  namespace: curl
spec:
  sources:
  - kind: ServiceAccount
    name: curl
    namespace: curl
  hosts:
  - httpbin.org
  ports:
  - number: 80
    protocol: http
EOF
