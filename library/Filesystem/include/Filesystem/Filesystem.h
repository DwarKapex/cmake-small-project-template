#pragma once
#include <string>

namespace kit::fs {

/**
 * \brief Interface for filesystem
 */
class IFilesystem {
    public:
        IFilesystem() = default;
        /**
         * \brief Check if the path exists
         * 
         * \param[in] path Path to entity to check existence for
         * \return true If path exists
         * \return false If path does not exist
         */
        virtual bool exists(const std::string & path) = 0;

        virtual ~IFilesystem() = default;
};

/**
 * \brief I/O operations on real OS filesystem
 */
class Filesystem: public IFilesystem {
    public:
        Filesystem() = default;
        /**
         * \brief Check if the path exists in OS filesystem
         * 
         * \param[in] path Path to entity to check existence for
         * \return true If path exists
         * \return false If path does not exist
         */
        bool exists(const std::string &) override;

        ~Filesystem() = default;
};

/**
 * \brief I/O operations on filesystem that is placed in memory to avoid 
 * disk I/O (for instance, for test purposes)
 */
class MemoryFilesystem: public Filesystem {
    public:
        MemoryFilesystem() = default;
        /**
         * \brief Check if the path exists in filesystem that is operate in memory
         * 
         * 
         * \param[in] path Path to entity to check existence for
         * \return true If path exists
         * \return false If path does not exist
         */

        bool exists(const std::string &) override;

        ~MemoryFilesystem() = default;
};

} // namespace kit::fs