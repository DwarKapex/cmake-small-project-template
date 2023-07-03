add_project_library(STATIC
                    PUBLIC Filesystem
                    PRIVATE Tools)

configure_file ("${CMAKE_CURRENT_LIST_DIR}/include/HelloWorld/version.h.in" 
                "${CMAKE_CURRENT_LIST_DIR}/include/HelloWorld/version.h")

add_subdirectory(test)