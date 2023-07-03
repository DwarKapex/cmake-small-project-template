# CMake Small Project Template

Welcome to CMake Small Project Template

This is my personal vision of how small C++ project should be organized 
for better readability and easy-to-maintain.

The full documentation can be build as follows:

1. Clone the repo:

```bash
$> cd <path/to/folder/>
$> git clone https://github.com/DwarKapex/cmake-small-project-template.git
```

2. Build documentation using [docker](https://docs.docker.com/):

```bash
$> cd <path/to/folder/>/cmake-small-project-template
$> docker build -t cspt-docs .
$> docker run -p 8080:8080 cspt-docs
```

You should be able to navigate to `http://127.0.0.1:8080` and see the documentation website running.

Feel free to leave any comments, recommendations and etc. If you found an issue, do not hesitate to shout it out.