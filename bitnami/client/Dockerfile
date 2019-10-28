FROM fedora/ssh:latest
## RUN dnf -y update && \
RUN dnf -y install wget git tar which curl python && \
    dnf clean all && \
    rm -rf /var/cache/yum
RUN pip install cqlsh

