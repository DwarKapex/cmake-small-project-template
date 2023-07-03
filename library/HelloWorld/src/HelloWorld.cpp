#include <HelloWorld/HelloWorld.h>
#include <Filesystem/Filesystem.h>
#include <Tools/YetAnotherTool.h>

namespace HelloWorld {

int HelloWorld(int n) {
    return n+1;
}

bool PathExists(const std::string &path, kit::fs::Filesystem fs){
    return tools::YetAnotherTool(43);
}

} // namespace HelloWorld