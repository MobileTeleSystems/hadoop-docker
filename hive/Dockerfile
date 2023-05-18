ARG BASE_IMAGE=mtsrus/hadoop:hadoop2-yarn

FROM alpine:3.17.3 AS hive-cache

ARG HIVE_VERSION=2.1.1
ENV HIVE_HOME /opt/hive

RUN wget https://apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz || wget https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar -xzf apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    rm apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    mv apache-hive-${HIVE_VERSION}-bin $HIVE_HOME && \
    rm -rf $HIVE_HOME/examples/ && \
    wget -q https://repo1.maven.org/maven2/org/postgresql/postgresql/42.6.0/postgresql-42.6.0.jar && \
    mv postgresql-42.6.0.jar $HIVE_HOME/lib/

FROM $BASE_IMAGE

ARG HIVE_VERSION=2.1.1
ENV HIVE_HOME /opt/hive
ENV PATH $PATH:$HIVE_HOME/bin

COPY --from=hive-cache $HIVE_HOME $HIVE_HOME
RUN mkdir -p /var/hive/conf

# Override configuration files
VOLUME /var/hive/conf

# Hive port
EXPOSE 10000

COPY conf/hive/* $HIVE_HOME/conf/
COPY scripts/ /scripts/
COPY *.sh /
RUN chmod +x /scripts/*.sh /*.sh

ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK --interval=30s --timeout=10s --start-period=360s --retries=3 CMD ["/opt/hive/bin/beeline", "-u", "jdbc:hive2://localhost:10000", "-e", "show databases"]
