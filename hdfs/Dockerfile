FROM eclipse-temurin:8-jre

ARG HADOOP_VERSION=2.7.3

ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
ENV LD_LIBRARY_PATH $HADOOP_HOME/lib/native:$LD_LIBRARY_PATH

RUN apt-get update && apt-get install --no-install-recommends -y openssh-client openssh-server

RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz || wget http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
    rm hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} $HADOOP_HOME && \
    rm -rf $HADOOP_HOME/share/doc/ && \
    find $HADOOP_HOME -name "*-sources.jar" -delete

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

# Namenode IPC port
EXPOSE 9820

# Namenode WebHDFS port
EXPOSE 9870

# Datanode UI port
EXPOSE 9864

# Datanode IPC port
EXPOSE 9867

COPY conf/hadoop/* $HADOOP_CONF_DIR/
COPY scripts/ /scripts/
COPY *.sh /
RUN chmod +x /scripts/*.sh /*.sh

ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=3 CMD ["hdfs", "dfs", "-ls", "/user/root"]
