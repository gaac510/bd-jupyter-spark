# bd-jupyter-spark

## The Purpose of This Repo

This repo was part of the outcomes of a school project. The purpose of this repo
was to run a Jupyter frontend and an Apache Spark cluster, all on a single host
computer. (Running a Spark cluster on a single host may not be more performant
than running a single Spark instance. This repo does it this way to support
learning of how Apache Spark achieves distributed computing.)

## Features

### The `docker-compose.yml` File

This repo contains a `docker-compose.yml` file which any host with Docker
installed can run without additional configuration and have within the same
Docker network:

- A container running Jupyter server
- A container running a Spark master instance
- Four containers, each running a Spark worker instance

Moreover:

- The workers automatically register with the master.
- The master service is accessible within the network at
  `spark://spark-master:7077`.
- The working directory and some config directories of the Jupyter container
  have been mapped to inside the `jupyter-home` directory.

### The `data` Directory

The `data` directory in this repo is mapped to `/data` in all containers, so
that all services therein can refer to the same static path to access any
data files. This is necessary since Jupyter, as the driver, does not send
data files to the Spark cluster, and all components, i.e the driver, the cluster
manager and the executors, have to refer to the same source data location.

The same `data` directory is also mapped to inside the working directory of the
Jupyter container, so that any data files can be directly accessed in the
Jupyter frontend.

### The `x` Script File

Executing `./x` does the following.

- Start the Docker containers in headless mode.
- As soon as the above is done, open and follow the containers logs.
- If the log following process is terminated, the containers will be stopped and
  removed.

Executing `./x token` while the Jupyter container is running will get the token
for logging into the Jupyter frontend. The other option to log into the Jupyter
frontend is to look for the login link/token in the Jupyter container's log.

Executing `./x <any command>` except the above will execute the command inside
the Jupyter container.

## Things to Note

- The container images used and the runtime versions are as the following.

Image | PySpark | Python | OpenJDK
--- | --- | ---
[gaac510docker/jupyter-all-spark:3.3.1-python3.8-jdk8](https://hub.docker.com/r/gaac510docker/jupyter-all-spark) | 3.3.1 | 3.8.13 | 1.8.0_352 (JKD8)
[bitnami/spark:3.3.1](https://hub.docker.com/r/bitnami/spark) | 3.3.1 | 3.8.15 | 1.8.0_352 (JKD8)
- 