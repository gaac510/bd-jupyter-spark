# How to use this data directory

This data directory is mapped from the `data` directory in the root of the host repository. The same directory is also mapped to the `/data` directory of all containers in the network. These mappings can be verified in the `docker-compse.yml` file in the host repository.

The mapping of the `data` directory was set up this way so that:

* All containers can refer to the same literal path, i.e `/data`, to access data files.
* The same data files can also be conveniently accessed from within Jupyter in case direct manipulation is desired.