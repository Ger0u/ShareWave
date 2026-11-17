cmake_minimum_required(VERSION 3.26)

project(ShareWave)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Boost REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(libsodium REQUIRED)

add_subdirectory(src)

option(SHAREWAVE_ENABLE_TESTING "Enable testing" ${PROJECT_IS_TOP_LEVEL})
if(SHAREWAVE_ENABLE_TESTING)
    enable_testing()
    add_subdirectory(tests)
endif()
