# CMake Small Project Template

Welcome to the documentation for CMake Project Template

This is my personal vision of how a small C++ project should be organized (using CMake)
in terms of folder structure for better readability and easy to maintain. 

There are no new abstractions, pure CMake and wrappers around some its functions.

If you're reading this, that means that you've cloned the repo successfully. Hooray! As this repo
works with CMake, you need to install it. Please follow this [instruction](https://cmake.org/install/) to 
accomplish this simple task. Note that this repo is for CMake version 3.15 or higher.

I use `*googletest*` as a unit test framework, so if you want to run unit-tests, please clone related submodule as well:

```bash
$> cd <path/to/folder/>/cmake-small-project-template
$> git submodule update --init --recursive
```

Now everything is set up and ready for testing. Navigate to [CMake/General](cmake/general.md) to get started and get a better idea of how to run it and learn more about concepts in use.


