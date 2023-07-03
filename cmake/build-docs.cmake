include_guard()

# enable doxygen first to build doxygen config file
set(ENABLE_DOXYGEN YES)
include(doxygen/doxygen)

# run script to build docs to /tmp/docs
add_custom_target(docs ALL /usr/bin/bash ${PROJECT_SOURCE_DIR}/docs/build_docs.sh ${PROJECT_BINARY_DIR}/doxygen.config)

message(STATUS "Docs will be available at /tmp/docs")