FROM python:2.7-alpine3.8

WORKDIR /

ENV CQLVERSION="3.4.4" \
    CQLSH_HOST="cassandra" \
    CQLSH_PORT="9042"

RUN pip install -Ivq cqlsh==5.0.4 \
    && apk add --no-cache bash \
    && echo 'alias cqlsh="cqlsh --cqlversion 3.4.4 $@"' >> /.bashrc \
    && source /.bashrc \
    && mkdir /.cassandra

#COPY ["entrypoint.sh", "/usr/local/bin"]

USER nobody

#CMD ["entrypoint.sh"]

CMD tail -f /dev/null
