FROM eclipse-temurin:8-jdk

ENV DEBIAN_FRONTEND noninteractive

ENV ANT_VERSION 1.10.13

ENV ANT_HOME /opt/apache-ant
ENV PATH ${ANT_HOME}/bin:$PATH

RUN curl --silent --location --retry 3 \
		http://mirrors.tuna.tsinghua.edu.cn/apache/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz \
		| tar xz -C /tmp && \
	mv /tmp/apache-ant-${ANT_VERSION} /opt/apache-ant-${ANT_VERSION} && \
	ln -s /opt/apache-ant-${ANT_VERSION} ${ANT_HOME} && \
	rm -rf /tmp/*

RUN set -eux; \
apt-get update; \
	apt-get install -y --no-install-recommends \
		git \
	; \
	rm -rf /var/lib/apt/lists/*;

RUN set -eux; \
apt-get update; \
        apt-get install -y --no-install-recommends \
                ssh \
                vim \
        ; \
        rm -rf /var/lib/apt/lists/*;

RUN set -eux; \
apt-get update; \
        apt-get install -y --no-install-recommends \
                make \
        ; \
        rm -rf /var/lib/apt/lists/*;

WORKDIR ${ANT_HOME}

CMD ["/bin/bash"]
