# #find gtest
set(GTEST_SEARCH_PATH "${PROJECT_SOURCE_DIR}/3rd-party/googletest")
set(GOOGLETEST_ROOT ${GTEST_SEARCH_PATH} CACHE STRING "Google Test source root")

set(GTEST_FOUND "NO")
if (EXISTS ${GOOGLETEST_ROOT})
    set(GTEST_FOUND "YES")
    add_subdirectory(
        "${GOOGLETEST_ROOT}"
        "googletest"
    )
    include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})
else()
    # if google test is not present as submodule, let's try
    # to find it with the help of CMake
    find_package(GTest 
             REQUIRED COMPONENTS gtest gmock
    )

    message(STATUS "GTest include dirs: ${GTest_INCLUDE_DIRS}")
    message(STATUS "GTest libs: ${GTest_LIBRARIES}")
endif()

if (NOT GTEST_FOUND)
    message(FATAL_ERROR "Google Test was not found under ${GTEST_SEARCH_PATH}")
endif()


