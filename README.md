# Open Service Mesh Crash Course

This repository contains the manifests and the presentation to demo the OSM project. Please watch an online version of the presentation [here](nolink) and follow the instructions below to try the demo yourself.

## Instructions

1. Download the OSM CLI from the [releases page](https://github.com/openservicemesh/osm/releases/) and place it in the same location as the `prepare.sh` script.
2. Execute the `prepare.sh` script. The script will install OSM on your cluster and deploy the demo application.

## Application UI

Launch the following URLs to access the application UI:

1. **Bookstore V1**: http://localhost/bookstore-v1
2. **Bookstore V2**: http://localhost/bookstore-v2
3. **Bookbuyer**: http://localhost/bookbuyer
4. **Bookthief**: http://localhost/bookthief

You can access the observability tools at the following URLs:

1. **Prometheus**: http://localhost:7070
2. **Grafana**: http://localhost:3000
3. **Jaeger**: http://localhost:16686
