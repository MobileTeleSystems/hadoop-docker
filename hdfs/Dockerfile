FROM eclipse-temurin:8-jre

ARG HADOOP_MAJOR_VERSION=2.7
ARG HADOOP_VERSION=2.7.3

ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
ENV LD_LIBRARY_PATH $HADOOP_HOME/lib/native:$LD_LIBRARY_PATH

RUN apt-get update && apt-get install --no-install-recommends -y openssh-client openssh-server

RUN wget -q http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
    rm hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} $HADOOP_HOME

COPY conf/ssh_config /root/.ssh/config
RUN for user in hadoop hdfs yarn mapred; do \
         useradd -U -M -d /opt/hadoop/ --shell /bin/bash ${user}; \
    done && \
    for user in root hdfs yarn mapred; do \
         usermod -G hadoop ${user}; \
    done && \
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys && \
    mkdir -p /var/hadoop/conf /var/hadoop/data /run/sshd

ENV WAIT_TIMEOUT_SECONDS=120

# Override configuration files
VOLUME /var/hadoop/conf

# HDFS data
VOLUME /var/hadoop/data

# Source: https://ambari.apache.org/1.2.3/installing-hadoop-using-ambari/content/reference_chap2_1.html

# Namenode IPC ports
EXPOSE 8020
EXPOSE 9000

# Namenode WebHDFS port
EXPOSE 50070

# Datanode UI port
EXPOSE 50075

COPY conf/hadoop/* $HADOOP_CONF_DIR/
COPY scripts/ /scripts/
COPY *.sh /
RUN chmod +x /scripts/*.sh /*.sh

ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=3 CMD ["hdfs", "dfs", "-ls", "/user/root"]
