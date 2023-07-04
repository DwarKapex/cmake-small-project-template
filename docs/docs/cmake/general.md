# Build and run
## Build

Run these simple commands to build and test the example:

```bash
$> cd </path/to/folder>
$> mkdir build
$> cd build
$> cmake ../cmake-small-project-template -D BUILD_DOCS:Bool=YES -D UNIT_TEST_FRAMEWORK:String=GTEST -D ENABLE_TESTING:Bool=YES
$> cmake --build .
```

Detailed explanation:

1. Navigate to the folder you cloned the repo and create *build* folder.

```bash
$> cd </path/to/folder>
$> mkdir build
```

It is a general recommendation to keep *build* folder apart from the folder with source files to avoid mess them up. But it's totally up to you and you can create it inside repo folder or any other place (don't forget to update path to the source folder for commands below)

2. Generate the project:

```bash
$> cmake ../cmake-small-project-template -D BUILD_DOCS:Bool=YES -D UNIT_TEST_FRAMEWORK:String=GTEST -D ENABLE_TESTING:Bool=YES
```

This command generates the CMake project using standard Unix makefiles. If you'd like to generate the project for your favorite IDE, check first that it is supported by your CMake by using the following command:

```bash
$> cmake -G
```

It lists all available generators for installed CMake.

Another available option for the project generations is a usage of [ccache](https://ccache.dev/). If you have it installed, do not hesitate to activate it with flag `ENABLE_CCACHE`:

```bash
$> cmake ../cmake-small-project-template -D ENABLE_CCACHE:Bool=YES -D BUILD_DOCS:Bool=YES -D UNIT_TEST_FRAMEWORK:String=GTEST -D ENABLE_TESTING:Bool=YES
```

3. And finally build the project completely:

```bash
$> cmake --build .
```

## Run

As an example you can run 

* all unit-test:

```bash
$> ctest
```

* single test:

```bash
$> ctest -R test_libFilesystem
```

 * `HelloWorld` app:

```bash
$> ./apps/HelloWorld/AppHelloWorld
```
