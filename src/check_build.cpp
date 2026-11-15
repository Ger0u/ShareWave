#include "sharewave/check_build.hpp"
#include <boost/range/algorithm.hpp>

namespace sharewave::check_build {

void sort(std::vector<int>& v) {
    boost::sort(v);
}

} // namespace sharewave::check_build
