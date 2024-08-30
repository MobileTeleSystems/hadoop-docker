# Changelog

## 1.7.0

* Update Hive to 2.3.10 for Hadoop 2.x
* Set ``yarn.nodemanager.hostname`` and ``yarn.resourcemanager.hostname`` to container hostname

## 1.6.0

* [DOP-6758] Add Hive Metastore server to hive image. It is started by default, but can be disabled by passing `WITH_HIVE_METASTORE_SERVER=false`
* [DOP-6758] Allow to skip starting Hive server by passing `WITH_HIVE_SERVER=false`
* [DOP-6758] Replace environment variables:
  * `POSTGRES_HOST`, `POSTGRES_PORT`, `POSTGRES_DB` -> `HIVE_METASTORE_DB_URL`
  * None -> `HIVE_METASTORE_DB_DRIVER`
  * `POSTGRES_USER` -> `HIVE_METASTORE_DB_USER`
  * `POSTGRES_PASSWORD` -> `HIVE_METASTORE_DB_PASSWORD`
  * `WITH_MAPREDUCE` -> `WITH_JOBHISTORY_SERVER`
* [DOP-6758] Improve healthcheck of Yarn and Hive images - check not only main service, but also services used as dependencies
* [DOP-6758] Cleanup old logs before starting services
* [DOP-6758] Add `|SERVICE|` prefix to startup logs of services
* [DOP-6758] Add environment variables `HADOOP_VERSION` and `HIVE_VERSION` to images
* [DOP-6758] Remove unused ports from docker-compose.yml
* [DOP-6758] Add Hive Admin UI port to docker-compose.yml


## 1.5.0

* [DOP-6758] Update Hive to 2.3.9 for Hadoop 2.x

## 1.4.0

* [DOP-4594] Revert: Upgrade hdfs data during start
* [DOP-4594] Log then services are ready
* [DOP-4594] Add `|SERVICE|` prefix to log lines
* [DOP-4594] Add YARN ports to Hive docker-compose.yml

## 1.3.0

* [DOP-4594] Increase memory limit per process to 512Mb

## 1.2.1

* [DOP-4594] Use https://dlcdn.apache.org instead of https://apache.org/dist

## 1.2.0

* [DOP-4594] Add substitutions support in metastore URL
* [DOP-4594] Use http://archive.apache.org only as fallback URL if package is missing in https://apache.org/dist
* [DOP-4594] Upgrade hdfs data during start

## 1.1.0

* [DOP-3130] Use same ports for Hadoop 2 & 3

## 1.0.2

* [DOP-3130] Fix missing logs

## 1.0.1

* [DOP-3130] Remove docs & tests & examples from image

## 1.0.0

* [DOP-3130] Initial release
