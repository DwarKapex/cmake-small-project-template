#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOXYGEN_CONFIG=$1

# mkdics output folder
MKDOCS_OUTPUT="/tmp/docs"
DOXYGEN_OUTPUT=${MKDOCS_OUTPUT}/doxygen
# find mkdocs binary
MKDOCS=$(which mkdocs)

# create output folder for docs
mkdir -p ${MKDOCS_OUTPUT}
# build the output
echo "mkdocs ${MKDOCS}"
if [[ ! -z ${MKDOCS} ]]; then
    ${MKDOCS} build --site-dir ${MKDOCS_OUTPUT} --config-file ${SCRIPT_DIR}/mkdocs.yml
else
    echo "mkdocs is missing, cannot build docs from source"
fi

# build doxygen docs only if the doxygen config is provided
if [[ ! -z ${DOXYGEN_CONFIG} ]];then
    mkdir -p ${DOXYGEN_OUTPUT}
    doxygen ${DOXYGEN_CONFIG}
fi
