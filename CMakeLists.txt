# work with CMake version not less then 3.15
cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

# set the project name
set(project_name "CMAKE_TEMPLATE")

# set build version
# if it is not defined as environment variable, read it from CMake cache 
# automatically update only minor version, major one is on developer.
if (NOT PROJECT_VERSION)
    set(PROJECT_VERSION "0.0" CACHE STRING "Version of a project [major.minor]")
endif()

# set build number for iterative builds.
# set env varible name to try to read it from.
set(env_build_number TRAVIS_BUILD_NUMBER)
set(project_build_number 1)
# if env variable does not exists, the project build number
# remains 1
if (DEFINED ENV{${env_build_number}})
    set(project_build_number ENV{${env_build_number}})
endif()

# build options
# build docs in doxygen format
option(BUILD_DOCS "Generate documentation" OFF)
# enable testing
option(ENABLE_TESTING "Build small (unit) tests")
# what engine to use for unit testing
set(UNIT_TEST_FRAMEWORK GTEST CACHE STRING "Test engine to work with. Only BOOST and GTest are supported so far")
# variants for cmake-ui
set_property(CACHE UNIT_TEST_FRAMEWORK PROPERTY STRINGS GTEST BOOST)
# enable CCACHE
option(ENABLE_CCACHE "Enable CCACHE for building" NO)

# Set cmake module path: path where to search for other *.cmake files
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

# ================ Project ========================

project(${project_name}
        VERSION ${PROJECT_VERSION}.${project_build_number}
        LANGUAGES C CXX
)

# set default C++ standard
set(CMAKE_CXX_STANDARD 17)

include(c++-config)
include(helpers)
include(project-target)

# find unit test framework
if (ENABLE_TESTING)
    if (UNIT_TEST_FRAMEWORK STREQUAL "GTEST")
        include(find-gtest)
    elseif(UNIT_TEST_FRAMEWORK STREQUAL "BOOST")
        include(find-boost)
    else()
        message(FATAL_ERROR "Unsupported unit test framework: ${UNIT_TEST_FRAMEWORK}. The options are GTEST, BOOST")
    endif()
    enable_testing()
endif()

# generate docs in doxygen format if requested
if (BUILD_DOCS)
    include(build-docs)
endif()

# use ccache to speed up the compilation
if (ENABLE_CCACHE)
    include(enable-ccache)
else()
    message(STATUS "Ccache is disabled")
endif()

# The libraries code is here
add_subdirectory(library)

# Apps for testing or any other purposes are here
add_subdirectory(apps)