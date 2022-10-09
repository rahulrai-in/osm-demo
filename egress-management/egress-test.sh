# Egress is blocked hence this command will fail
kubectl exec $(kubectl get pod -n curl -l app=curl -o jsonpath='{.items..metadata.name}') -n curl -c curl -- curl -sI http://httpbin.org:80/get
