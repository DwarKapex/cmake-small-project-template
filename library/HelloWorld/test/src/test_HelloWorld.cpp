#include <gtest/gtest.h>
#include <test_HelloWorld.h>
#include <HelloWorld/HelloWorld.h>
#include <Filesystem/Filesystem.h>

TEST(HelloWorld, TestOne) { 
    EXPECT_EQ(1, HelloWorld::Unittest::HelloWorldTesthelper(0));
    EXPECT_EQ(43, HelloWorld::Unittest::HelloWorldTesthelper(42));
}

TEST(HelloWorld, PathExists) { 
    kit::fs::MemoryFilesystem mfs;
    EXPECT_TRUE(HelloWorld::PathExists("/tmp", mfs));
}
