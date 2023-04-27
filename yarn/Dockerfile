ARG BASE_IMAGE=mtsrus/hadoop:hadoop2-hdfs
FROM $BASE_IMAGE

ENV WITH_MAPREDUCE=false

# Yarn ports: https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.3/administration/content/yarn-ports.html

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

# MapRecduce ports: https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.3.5/administration/content/mapreduce-ports.html
# JobHistory server IPC
EXPOSE 10020
# JobHistory server UI
EXPOSE 19888

COPY conf/hadoop/* $HADOOP_CONF_DIR/
COPY scripts/ /scripts/
COPY *.sh /
RUN chmod +x /scripts/*.sh /*.sh

ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK --interval=30s --timeout=10s --start-period=300s --retries=3 CMD ["curl", "-s", "-f", "http://localhost:8042/jmx?qry=Hadoop:*"]
