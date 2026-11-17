#include <gtest/gtest.h>
#include "sharewave/check_build.hpp"

TEST(CheckBuild, SortsUnsortedVector) {
    std::vector<int> v = {3, 1, 2};
    sharewave::check_build::sort(v);
    EXPECT_EQ(v, std::vector<int>({1, 2, 3}));
}

TEST(CheckBuild, EmptyVectorRemainsEmpty) {
    std::vector<int> v;
    sharewave::check_build::sort(v);
    EXPECT_TRUE(v.empty());
}
