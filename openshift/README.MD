## Cassandra deployment on OpenShift

### Creating the Headless Service
````
oc create -f cassandra-service.yaml
````

### Creating the StatefulSet
````
oc create -f cassandra-statefulset.yaml
````
