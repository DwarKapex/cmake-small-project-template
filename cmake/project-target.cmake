function(add_project_library)
	set(prefix	project_library_args)
	set(all_lib_types STATIC SHARED)
	set(optionArgs ${all_lib_types})
    set(singleValuesArgs NAME)
    set(multiValueArgs PUBLIC PRIVATE)

    cmake_parse_arguments(${prefix} "${optionArgs}" "${singleValuesArgs}" "${multiValueArgs}" ${ARGN})

	get_filename_component(lib_name "${CMAKE_CURRENT_LIST_DIR}" NAME)
	if ("${${prefix}_NAME}" STREQUAL "")
		set(lib_name lib${lib_name})
	else()
		set(lib_name ${${prefix}_NAME})
	endif()

	glob_target_files(${lib_name} 
					  TARGET_ROOT ${CMAKE_CURRENT_LIST_DIR})

	# Verify content
    if ((NOT ${lib_name}_SOURCE) AND (NOT ${lib_name}_HEADER))
        message(FATAL_ERROR "Target ${lib_name} added in ${CMAKE_CURRENT_LIST_DIR} does not have any source files (must be in 'src' or 'include' subdirectories).")
	endif()

	if (NOT ${lib_name}_SOURCE)
		message(WARN " Attempt to build header-only lib. No target will be generated")
		return()
	endif()

	set(lib_type "")
	foreach(type IN LISTS all_lib_types)
		if (${prefix}_${type})
			if (NOT ${lib_type} STREQUAL "")
				message(FATAL_ERROR "You cannot specify more than one library type [issue is with target ${lib_name}]")
			endif()
			set(lib_type ${type})
		endif()
	endforeach()
	if (lib_type STREQUAL "") 
		set(lib_type STATIC)
	endif()
	add_library(${lib_name}
		${lib_type}
		${${lib_name}_SOURCE}
	)

	# set target properties
	set_target_properties(${lib_name} 
		PROPERTIES
    		CXX_STANDARD_REQUIRED ON
			# set target to be equal to lib name and avoid adding 
			# extra `lib` at the beginning
			PREFIX ""
	)


	# Set the includes property. This should automatically populate the include directories of any
	# targets who link to ${lib_name} at build time.
	list (GET ${lib_name}_HEADER 0 target_INCLUDE_DIRS_FIRST)
	target_include_directories(${lib_name} 
				PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include )
	set(private_lib_dependencies "")
	foreach(dep IN LISTS ${prefix}_PRIVATE)
		list(APPEND private_lib_dependencies lib${dep})
	endforeach()
	set(public_lib_dependencies "")
	foreach(dep IN LISTS ${prefix}_PUBLIC)
		list(APPEND public_lib_dependencies lib${dep})
	endforeach()
	target_link_libraries(${lib_name}
			PRIVATE ${private_lib_dependencies}
			PUBLIC  ${public_lib_dependencies})

endfunction()

function(add_project_test)
	if (NOT ENABLE_TESTING)
		return()
	endif()
	# Generate default test
	get_filename_component(test_dir "${CMAKE_CURRENT_LIST_DIR}" PATH)
	get_filename_component(target_name "${test_dir}" NAME)
	if(CMAKE_CURRENT_LIST_DIR MATCHES ".*apps.*") 
		set(test_entity "app")
	elseif (CMAKE_CURRENT_LIST_DIR MATCHES ".*library.*")
		set(test_entity "lib")
	endif()
	set(test_name "test_${test_entity}${target_name}")
	
	glob_target_files(${test_name} 
					  TARGET_ROOT ${CMAKE_CURRENT_LIST_DIR})
	# Verify content
    if ((NOT ${test_name}_SOURCE) AND (NOT ${test_name}_HEADER))
        message(FATAL_ERROR "Target ${lib_name} added in ${CMAKE_CURRENT_LIST_DIR} does not have any source files (must be in 'src' or 'include' subdirectories).")
	endif()
	
	add_executable(${test_name}
		${${test_name}_SOURCE}
	)
	
	if (UNIT_TEST_FRAMEWORK STREQUAL "BOOST")
		set_target_properties(${test_name} PROPERTIES
			COMPILE_DEFINITIONS BOOST_TEST_DYN_LINK
			INCLUDE_DIRECTORIES ${Boost_INCLUDE_DIR}
			CXX_STANDARD_REQUIRED ON
		)
	
		target_link_libraries(${test_name} 
			${target_name}
			${Boost_LIBRARIES}
		)
	elseif(UNIT_TEST_FRAMEWORK STREQUAL "GTEST")
		set_target_properties(${test_name} PROPERTIES
			CXX_STANDARD_REQUIRED ON
		)

		target_link_libraries(${test_name}
			lib${target_name}
    		gtest gmock gtest_main
		)
	endif()
	target_include_directories(${test_name} PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include)
	add_test(${test_name} ${test_name})
endfunction()

function(add_and_install_project_app app_name)
	set(prefix  add_project_app)
	set(optionArgs "")
    set(singleValueArgs "")
    set(multiValueArgs DEPEND)

    cmake_parse_arguments(${prefix} "${optionArgs}" "${singleValueArgs}" "${multiValueArgs}" ${ARGN})

	glob_target_files(${app_name} 
					TARGET_ROOT ${CMAKE_CURRENT_LIST_DIR})

	# Verify content
	if ((NOT ${app_name}_SOURCE) AND (NOT ${app_name}_HEADER))
		message(FATAL_ERROR "Target ${app_name} added in ${CMAKE_CURRENT_LIST_DIR} does not have any source files (must be in 'src' or 'include' subdirectories).")
	endif()

	add_executable(${app_name}
		${${app_name}_SOURCE}
	)

	set(app_lib_dependency "")
	foreach(link_lib ${${prefix}_DEPEND})
		LIST(APPEND app_lib_dependency ${link_lib})
	endforeach()
	
	target_link_libraries(${app_name}
		${app_lib_dependency}	
	)	
	# set target properties
	set_target_properties(${app_name} PROPERTIES
		CXX_STANDARD_REQUIRED ON
	)

	# Set the includes property. This should automatically populate the include directories of any
	# targets who link to ${app_name} at build time.
	list (GET ${app_name}_HEADER 0 target_INCLUDE_DIRS_FIRST)
	target_include_directories(${app_name} PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include)

	# install
	install(TARGETS ${app_name} RUNTIME DESTINATION bin)

	# create deb package
	set(CPACK_GENERATOR DEB)
	set(CPACK_DEBIAN_PACKAGE_MAINTAINER KK)
	set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
	set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
	set(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")
	set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
	include(CPack)
endfunction()