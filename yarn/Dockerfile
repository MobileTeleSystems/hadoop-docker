ARG BASE_IMAGE=mtsrus/hadoop:hadoop2-hdfs
FROM $BASE_IMAGE

ENV WITH_JOBHISTORY_SERVER=false

# Yarn ports: https://kontext.tech/article/265/default-ports-used-by-hadoop-services-hdfs-mapreduce-yarn

# Scheduler (ApplicationMaster)
EXPOSE 8030
# ResourceTracker IPC
EXPOSE 8031
# ApplicationClient
EXPOSE 8032
# ResourceManager Admin
EXPOSE 8033
# NodeManager UI
EXPOSE 8042
# ResourceManager UI
EXPOSE 8088

# MapReduce ports: https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/cdh_ports.html
# JobHistory server IPC
EXPOSE 10020
# JobHistory server UI
EXPOSE 19888

# MapReduce Shuffle port:
EXPOSE 13562

COPY conf/hadoop/* $HADOOP_CONF_DIR/
COPY scripts/ /scripts/
COPY *.sh /
RUN chmod +x /scripts/*.sh /*.sh

ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK --interval=30s --timeout=10s --start-period=360s --retries=3 CMD ["/healthcheck.sh"]
