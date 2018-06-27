#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build ${SCRIPT_DIR}/ -t tensorflow

docker run -it -v $PWD:/notebooks tensorflow /bin/bash -c "echo 'Waiting for changes'; while inotifywait -r -e \"modify,close_write,move,create,delete\" /notebooks/ > /dev/null 2>&1; do clear; python3 /notebooks/$1; echo; echo 'Waiting for changes'; done"

