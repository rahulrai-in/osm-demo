# Note: Download OSM executable and place it in the same directory as this script

# Install OSM with obervability tools
./osm install --set=osm.deployPrometheus=true,osm.deployGrafana=true,osm.deployJaeger=true,osm.tracing.enable=true,osm.enablePermissiveTrafficPolicy=false,osm.enableEgress=false

# Create namespaces
for i in bookstore bookbuyer bookthief bookwarehouse; do kubectl create ns $i; done

# Add namespaces to the mesh
for i in bookstore bookbuyer bookthief bookwarehouse; do ./osm namespace add $i; done

# Enable metrics for pods belonging to app namespaces
for i in bookstore bookbuyer bookthief bookwarehouse; do ./osm metrics enable --namespace $i; done

# Install NGINX Ingress Controller and connect it to OSM
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.1/deploy/static/provider/cloud/deploy.yaml

kubectl label ns ingress-nginx openservicemesh.io/monitored-by=osm

kubectl wait --namespace ingress-nginx \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/component=controller \
    --timeout=120s

kubectl apply -f basic/.

# Expose prometheus and Grafana UI
OSM_POD=$(kubectl get pods -n osm-system --no-headers --selector app=jaeger | awk 'NR==1{print $1}')

kubectl port-forward -n osm-system svc/osm-prometheus 7070:7070 &
kubectl port-forward -n osm-system svc/osm-grafana 3000:3000 &
kubectl port-forward -n osm-system "$OSM_POD" 16686:16686

# Use the following to launch the Envoy Admin API UI
# kubectl port-forward -n bookbuyer pod/$(kubectl get pod -n bookbuyer -l app=bookbuyer -o jsonpath='{.items..metadata.name}') 15000:15000
