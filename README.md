# [Hadoop docker image](https://github.com/MobileTeleSystems/hadoop-docker)

[![Repo Status](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build Status](https://github.com/MobileTeleSystems/hadoop-docker/workflows/Test%20build/badge.svg)](https://github.com/MobileTeleSystems/hadoop-docker/actions)
[![Docker Image Version](https://img.shields.io/badge/docker-pull-blue)](https://hub.docker.com/r/mtsrus/hadoop)

**Test purpose only!**

## HDFS

All-in-one HDFS container with:

* HDFS namenode
* HDFS secondary namenode
* HDFS datanode

### Versions

* `mtsrus/hadoop:hadoop2.7.3-hdfs`
* `mtsrus/hadoop:hadoop2-hdfs` - same as above

* `mtsrus/hadoop:hadoop3.3.5-hdfs`
* `mtsrus/hadoop:hadoop3-hdfs` - same as above

### Prerequisites

Minimal resources could start with are:

* 200m CPU
* 700Mb RAM
* 1Gb storage

### Examples

See [docker-compose.yml](hdfs/docker-compose.yml).

### Port numbers

NOTE: Hadoop 2 image uses the same port numbers as Hadoop 3:

- `9820:9820` - HDFS IPC
- `9870:9870` - WebHDFS

### Configuration

#### `/var/hadoop/conf/*.xml` files

##### Defaults

* [/var/hadoop/conf/core-site.xml](hdfs/conf/hadoop/core-site.xml)
* [/var/hadoop/conf/hdfs-site.xml](hdfs/conf/hadoop/hdfs-site.xml)

You can mount custom config files to `/var/hadoop/conf` directory inside container to override default Hadoop configuration.

##### Substitutions

The following substitutions are replaced with proper values:

* `{{hostname}}` - current hostname

#### Container env variables

* `WAIT_TIMEOUT_SECONDS=120` - timeout in seconds after starting each service to check if it is alive

#### `/var/hadoop/conf/hadoop-env.sh` environment variables

##### Defaults

* `export HADOOP_HEAPSIZE=512` - max JVM memory in megabytes, applied for all Hadoop components (if no overrides)

If container fails with `OutOfMemory`, you should increase this value, e.g. up to `1024` or `2048`.

##### Variables per service

* `export HADOOP_NAMENODE_OPTS=-Xmx2048m` - max JVM memory for Namenode
* `export HADOOP_SECONDARYNAMENODE_OPTS=-Xmx2048m` - max JVM memory for Secondary Namenode
* `export HADOOP_DATANODE_OPTS=-Xmx1024m` - max JVM memory for Datanode

See https://hadoop.apache.org/docs/r2.7.6/hadoop-project-dist/hadoop-common/ClusterSetup.html#Configuring_Environment_of_Hadoop_Daemons

## Yarn

All-in-one Yarn container with:

* HDFS namenode
* HDFS secondary namenode
* HDFS datanode
* Yarn ResourceManager
* Yarn NodeManager
* MapReduce JobHistory server (if `WITH_JOBHISTORY_SERVER=true`)

### Versions

* `mtsrus/hadoop:hadoop2.7.3-yarn`
* `mtsrus/hadoop:hadoop2-yarn` - same as above

* `mtsrus/hadoop:hadoop3.3.5-yarn`
* `mtsrus/hadoop:hadoop3-yarn` - same as above

### Prerequisites

Minimal resources could start with are:

* 400m CPU
* 1Gb RAM
* 1Gb storage

### Examples

See [docker-compose.yml](yarn/docker-compose.yml).

### Port numbers

NOTE: Hadoop 2 image uses the same port numbers as Hadoop 3:

- `9820:9820` - HDFS IPC
- `9870:9870` - HDFS WebHDFS
- `8042:8042` - NodeManager UI
- `8088:8088` - Yarn UI

if `WITH_JOBHISTORY_SERVER=true`:
- `10020:10020` - MapReduce JobServer
- `19888:19888` - MapReduce JobServer History

### Configuration

#### `/var/hadoop/conf/*.xml` files

##### Default

* [/var/hadoop/conf/core-site.xml](hdfs/conf/hadoop/core-site.xml)
* [/var/hadoop/conf/hdfs-site.xml](hdfs/conf/hadoop/hdfs-site.xml)
* [/var/hadoop/conf/yarn-site.xml](yarn/conf/hadoop/yarn-site.xml)
* [/var/hadoop/conf/capacity-scheduler.xml](yarn/conf/hadoop/capacity-scheduler.xml)
* [/var/hadoop/conf/mapred-site.xml](yarn/conf/hadoop/mapred-site.xml)

You can mount custom config files to `/var/hadoop/conf` directory inside container to override default Hadoop configuration.

##### Substitutions

The following substitutions are replaced with proper values:

* `{{hostname}}` - current hostname

#### Container env variables

* `WAIT_TIMEOUT_SECONDS=120` - ti_meout in seconds after starting each service to check if it is alive
* `WITH_JOBHISTORY_SERVER=false` - set to `true` to start MapReduce JobHistory server

#### `/var/hadoop/conf/hadoop-env.sh` environment variables


See HDFS image documentation.

#### `/var/hadoop/conf/yarn-env.sh` environment variables

* `export YARN_RESOURCEMANAGER_OPTS=-Xmx1024m` - max JVM memory for Yarn ResourceManager
* `export YARN_NODEMANAGER_OPTS=-Xmx1024m` - max JVM memory for NodeManager
* `export HADOOP_JOB_HISTORYSERVER_OPTS=-Xmx1024m` - max JVM memory for MapReduce JobHistory server

See https://hadoop.apache.org/docs/r2.7.6/hadoop-project-dist/hadoop-common/ClusterSetup.html#Configuring_Environment_of_Hadoop_Daemons


## Hive

All-in-one Hive container with:

* HDFS namenode
* HDFS secondary namenode
* HDFS datanode
* Yarn ResourceManager
* Yarn NodeManager
* MapReduce JobHistory server
* Hive server
* Hive Metastore server

### Versions

* `mtsrus/hadoop:hadoop2.7.3-hive2.3.10`
* `mtsrus/hadoop:hadoop2-hive` - same as above

* `mtsrus/hadoop:hadoop3.3.5-hive3.1.3`
* `mtsrus/hadoop:hadoop3-hive` - same as above

### Prerequisites

Minimal resources could start with are:

* 500m CPU
* 2Gb RAM
* 1Gb storage
* Running RDBMS (e.g. Postgres) instance to operate Metastore

### Examples

See [docker-compose.yml](hive/docker-compose.yml).

### Port numbers

NOTE: Hadoop 2 image uses the same port numbers as Hadoop 3:

- `9820:9820` - HDFS IPC
- `9870:9870` - HDFS WebHDFS

if `WITH_HIVE_SERVER=true`:
  - `8042:8042` - NodeManager UI
  - `8088:8088` - Yarn UI
  - `19888:19888` - MapReduce JobServer History
  - `10000:10000` - Hive server
  - `10002:10002` - Hive Admin UI

if `WITH_HIVE_METASTORE_SERVER=true`:
  - `9083:9083` - Hive Metastore server

### Configuration

#### `/var/hive/conf/*.xml` and `var/hadoop/conf/*.xml` files

##### Defaults

* [/var/hadoop/conf/hive-site.xml](hive/conf/hive/hive-site.xml)

You can mount custom config files to `/var/hive/conf` directory inside container to override default Hive configuration.

HDFS and Yarn configs still can be passed to `var/hadoop/conf` directory.

##### Substitutions

The following substitutions are replaced with proper values:

* `{{hostname}}` - current hostname
* `{{HIVE_METASTORE_DB_URL}}` - `HIVE_METASTORE_DB_URL` env variable (default `jdbc:postgresql://postgres:5432/metastore`)
* `{{HIVE_METASTORE_DB_DRIVER}}` - `HIVE_METASTORE_DB_DRIVER` env variable (default `org.postgresql.Driver`)
* `{{HIVE_METASTORE_DB_USER}}` - `HIVE_METASTORE_DB_USER` env variable (default `hive`)
* `{{HIVE_METASTORE_DB_PASSWORD}}` - `HIVE_METASTORE_DB_PASSWORD` env variable (default `hive`)

#### Metastore database

Hive stores metadata in `{{HIVE_METASTORE_DB_URL}}` using driver from `{{HIVE_METASTORE_DB_DRIVER}}`. By default, Postgres is used.

You can change URL components by setting environment variables mentioned above, or replace the entire URL by updating the `/var/hive/conf/hive-site.xml` file.

You can also use any other supported RDMBS, like MySQL, by changing connection URL and embedding/mounting JDBC driver to `/opt/hive/lib/drivername.jar` path inside container. Postgres JDBC driver is already embedded into image.

#### Container env variables

* `WAIT_TIMEOUT_SECONDS=120` - timeout in seconds after starting each service to check if it is alive
* `WITH_HIVE_SERVER=true` - set to `false` to disable Hive server
* `WITH_HIVE_METASTORE_SERVER=true` - set to `false` to disable Hive metastore server

#### `/var/hadoop/conf/hadoop-env.sh` environment variables

See HDFS image documentation.

#### `/var/hadoop/conf/yarn-env.sh` environment variables

See Yarn image documentation.

#### `/var/hive/conf/hive-env.sh` environment variables

* `export HIVE_SERVER2_HEAPSIZE=256` - max JVM memory in megabytes for Hive server
* `export HIVE_METASTORE_HEAPSIZE=256` - max JVM memory in megabytes for Hive metastore server

See https://www.alibabacloud.com/help/en/emr/emr-on-ecs/user-guide/modify-the-memory-parameters-of-hive
