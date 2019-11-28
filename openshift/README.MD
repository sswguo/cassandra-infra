## Cassandra deployment on OpenShift

### Use the config as ConfigMaps

The configMap is used in the stateful set config
````
oc create configmap cassandra-config --from-file conf/
````

### Creating the Headless Service
````
oc create -f cassandra-service.yaml
````

### Creating the StatefulSet
````
oc create -f cassandra-statefulset.yaml
````

### Scale the auth node
````
ALTER KEYSPACE system_auth WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1': 3};
````
