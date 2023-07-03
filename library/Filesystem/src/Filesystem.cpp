#include <Filesystem/Filesystem.h>

namespace kit::fs {

bool Filesystem::exists(const std::string &) {
    return true;
}


bool MemoryFilesystem::exists(const std::string &) {
    return false;
}

} // namespace kit::fs