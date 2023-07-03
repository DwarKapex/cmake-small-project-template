#include <gtest/gtest.h>
#include <Tools/CTFactorial.h>

TEST(Tools, CTFactorial) { 
    EXPECT_EQ(1, tools::Factorial<0>::value);
    EXPECT_EQ(6, tools::Factorial<3>::value);
}