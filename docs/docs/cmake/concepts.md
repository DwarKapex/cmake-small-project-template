# Concepts

Let's start with a folder structure. I want to keep it as simple as possible:

```bash
- 3rd-party
- apps
- cmake
- docs
- library
```

The names of each folder is self explained, but let me add some words here. 

## Library

The libraries (static or shared) are stored in folder `library`,
one subfolder per library:

```bash
- library
  ⊢ lib1
  ⊢ lib2
  ⊢ lib3
    ...
  ∟ CMakeLists.txt
```

To add/remove a library, you need to edit `library/CMakeLists.txt`:

```bash
# library/CMakeLists.txt
add_subdirectory(lib1)
add_subdirectory(lib2)
add_subdirectory(lib3)
...
```

Every such subfolder has a defined structure:

```bash
- library
  ⊢ lib1
    ⊢ include
      ⊢ lib1
        ∟ Header.h   
    ⊢ src
      ∟ Source.cpp
    ⊢ test
      ⊢ include
        ∟ test_header.h
      ⊢ src
        ∟ test_source.h 
      ∟ CMakeLists.txt    
    ∟ CMakeLists.txt  
```

where all headers are in `lib1/include/lib1`, all source files are under `lib1/src` and tests are obviously in `lib1/test`. You can skip either `include` or `src` folder but not both. The `include` folder for library repeats the name of the library, so that you can `#include` it in this manner:

```c++
#include <lib1/Header.h>
```

I try to keep `CMakeLists.txt` as short as possible:

```bash
# library/lib<N>/CMakeLists.txt
add_project_library()
add_subdirectory(test)
```

`add_project_library()` is a wrapper for CMake `add_target` which do the following:

* create a library with name `lib<FolderName>` (in the case above the target has name `liblib1` and related file name as `liblib1.so`)
* add headers so that if any other target requires it as a dependency, that target can include it in the manner showed above.

For more details look inside `cmake/project-target.cmake` and search for `add_project_library`.

`add_project_library` create a Also you can choose the type of the library you want to create (**STATIC**, **SHARED** or **INTERFACE**) as well as mention the dependencies:

```bash
# library/SomeLib/CMakeLists.txt
add_project_library(
    NAME SomeFancyName
    STATIC
    PUBLIC Filesystem
    PRIVATE Tools)
```

As you can see, here I create a static library with target name `SomeFancyName` (for those who want to control everything) and link `libFileSystem` as a public library and `libTools` as a private one.

Subfolder `test` has a similar structure with one exception: you don't need to repeat name `test` for `include` subfolder. Also corresponding `CMakeLists.txt` file contains only one line:

```bash
# library/HelloWorld/test/CMakeLists.txt
add_project_test()
```

The command above creates a target with name `test_libHelloWorld` and ready to be executed thru `ctest`.