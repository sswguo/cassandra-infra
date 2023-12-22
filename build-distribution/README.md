
Cassandra is built using Ant, and by default, the build uses Java 8. So firstly prepare the docker image with `ant` & `jdk8`

```
docker build -t ant_jdk8:0.1 .
```

Clone cassandra project under `workspace/`
```
mkdir -p ~/GitRepo/cassandra-infra/build-distribution/workspace
cd ~/GitRepo/cassandra-infra/build-distribution/workspace
git clone git@github.com:apache/cassandra.git
```

Start the container with the volumes
```
docker run -it --volume ~/GitRepo/cassandra-infra/build-distribution/workspace:/opt/apache-ant-1.10.13/workspace --volume ~/.m2/repository:/root/.m2/repository ant_jdk8:0.1 /bin/bash
```

Build the project accordingly, ref [Building a distribution](https://cassandra.apache.org/_/development/index.html)
```
root@496ec30b5509:/opt/apache-ant-1.10.13/workspace/cassandra# ant artifacts
```