# Image build

Build the image for cassandra based on the this Dockerfile, giving a tag accordingly
````
cd cassrandra

docker build . -t "jind0001/cassandra:latest"
````

Build an image just contains cqlsh
````
cd cqlsh

docker build . -t "jind0001/cqlsh:latest"
````
