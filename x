#!/usr/bin/env bash

set -a
. ./.env
set +a

if [[ "$#" -eq 0 ]]; then
    docker compose up --remove-orphans --wait
    docker compose logs -f
    docker compose down
elif [[ "$1" == 'down' ]]; then
    docker compose down
elif [[ "$1" == 'token' ]]; then
    docker exec -it bd-jupyter-spark-notebook-1 \
    cat "/home/${NB_USER}/.local/share/jupyter/runtime/jpserver-25.json" \
    | grep 'token'
else
    docker exec -it \
    bd-jupyter-spark-notebook-1 \
    "$@"
fi

# The below executes a command in a separate, new container in the network. Not
# used for now, but could become useful if, for example, a container containing
# network utilities (e.g. nicolaka/netshoot) is to be run for troubleshooting.
    # docker run -it --rm \
    # --network bd-jupyter-spark_default \
    # -u root \
    # -e "NB_USER=${NB_USER}" \
    # -e CHOWN_HOME=yes \
    # -w "/home/${NB_USER}/work" \
    # -v "${PWD}/home/work:/home/${NB_USER}/work" \
    # -v "${PWD}/home/.jupyter:/home/${NB_USER}/.jupyter" \
    # -v "${PWD}/home/.ipython:/home/${NB_USER}/.ipython" \
    # jupyter/all-spark-notebook:python-3.8 \
    # "$@"