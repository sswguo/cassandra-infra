### Cassandra Image

### TODO

### Monitor

Cassandra is one of many Java-based systems that offers metrics via JMX. The JMX Exporter offers way to use these with Prometheus. By following these steps to see how we use it.

We need the JMX exporter java agent, configuration, and to tell Cassandra to use it:

````
wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.12.0/jmx_prometheus_javaagent-0.12.0.jar
wget https://github.com/prometheus/jmx_exporter/blob/master/example_configs/cassandra.yml
echo 'JVM_OPTS="$JVM_OPTS -javaagent:'$PWD/jmx_prometheus_javaagent-0.12.0.jar=7070:$PWD/cassandra.yml'"' >> conf/cassandra-env.sh
````

That had been added in this image as follows:

- Dockerfile
````
... ...
 
RUN mkdir -p /opt/jmx_prometheus
COPY jmx_prometheus_javaagent/* /opt/jmx_prometheus/
 
## JMX Prometheus
# 7070
EXPOSE 7000 7001 7199 9042 9160 7070
 
... ...
````

- docker-entrypoint.sh
````
## === metrics agent
set -eux
echo 'JVM_OPTS="$JVM_OPTS -javaagent:'/opt/jmx_prometheus/jmx_prometheus_javaagent-0.12.0.jar=7070:/opt/jmx_prometheus/cassandra.yml'"' >> $CASSANDRA_CONFIG/cassandra-env.s
````

#### Add config in prometheus
````
- job_name: cassandra
  honor_timestamps: true
  scrape_interval: 1m
  scrape_timeout: 10s
  metrics_path: /metrics
  scheme: http
  static_configs:
  - targets:
    - cassandra-0.cassandra.<namespace>.svc.cluster.local:7070
    - cassandra-1.cassandra.<namespace>.svc.cluster.local:7070
    - cassandra-2.cassandra.<namespace>.svc.cluster.local:7070
````

