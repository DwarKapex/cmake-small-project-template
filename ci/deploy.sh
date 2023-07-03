project=HelloWorld
binary_name=hello_world
mkdir build
cd build
# generate the project
cmake .. -D BUILD_DOCS:Bool=YES -D UNIT_TEST_FRAMEWORK:String=GTEST -D ENABLE_TESTING:Bool=YES
# build lib
cmake --build . --target lib_$project
# build test for lib
cmake --build . --target test_$project
# run test
ctest test_$project
# build and install app
cmake --build . --target $binary_name
# build docs
cmake --build . --target docs
# generate deb package 
cpack