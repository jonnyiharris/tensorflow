#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

image_name="tensorflow_$(echo $1 | sed -e 's/\W/_/g')"

docker build ${SCRIPT_DIR}/ -t $image_name

if ! docker start $image_name -i; then
	docker run -it -v $PWD:/notebooks --name=$image_name tensorflow /bin/bash -c "echo 'Waiting for changes'; while inotifywait -r -e \"modify,close_write,move,create,delete\" /notebooks/ > /dev/null 2>&1; do clear; python3 /notebooks/$1; echo; echo 'Waiting for changes'; done"
fi

