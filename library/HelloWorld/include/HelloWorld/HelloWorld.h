#pragma once
#include <Filesystem/Filesystem.h>

namespace HelloWorld {

/**
 * \brief Check if some path exists
 * 
 * \param[in] path Path to check
 * \param[in] fs Filesystem to perform check on
 * \return true If exists
 * \return false Otherwise
 */
bool PathExists(const std::string &path, kit::fs::Filesystem fs);

/**
 * \brief Example function
 * 
 * \param[in] n Input number.
 * \return int Return n+1
 */
int HelloWorld(int n);

} // namespace HelloWorld