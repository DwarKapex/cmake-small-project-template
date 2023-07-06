# Build and run
## Build

To build and run the example, follow these simple commands:

```bash
$> cd </path/to/folder>
$> mkdir build
$> cd build
$> cmake ../cmake-small-project-template -D BUILD_DOCS:Bool=YES -D UNIT_TEST_FRAMEWORK:String=GTEST -D ENABLE_TESTING:Bool=YES
$> cmake --build .
```

Detailed explanation:

1. Navigate to the folder you cloned the repo to and create *build* folder.

```bash
$> cd </path/to/folder>
$> mkdir build
```

It is generally recommended to keep the build folder separate from the folder with the source files to avoid accidentally mixing them up. However, you can also create the build folder inside the repository folder or anywhere else. Just make sure to update the path to the source folder in the commands below accordingly.


2. Generate the project:

```bash
$> cmake ../cmake-small-project-template -D BUILD_DOCS:Bool=YES -D UNIT_TEST_FRAMEWORK:String=GTEST -D ENABLE_TESTING:Bool=YES
```

This command generates the CMake project using standard Unix makefiles. If you would like to generate the project for your favorite IDE, first check that it is supported by your CMake by running the following command:

```bash
$> cmake -G
```

It lists all available generators for installed CMake.

Another available option for the project generations is to use [ccache](https://ccache.dev/). You can activate it with the `ENABLE_CCACHE` flag:

```bash
$> cmake ../cmake-small-project-template -D ENABLE_CCACHE:Bool=YES -D BUILD_DOCS:Bool=YES -D UNIT_TEST_FRAMEWORK:String=GTEST -D ENABLE_TESTING:Bool=YES
```

3. Finally, build the project completely:

```bash
$> cmake --build .
```

## Run

Once the project is built, you can run the following commands to run the unit tests, a single test, or the HelloWorld app:

* Run all unit-test:

```bash
$> ctest
```

* Run single test:

```bash
$> ctest -R test_libFilesystem
```

 * Run the `HelloWorld` app:

```bash
$> ./apps/HelloWorld/AppHelloWorld
```
