add_library(sharewave_core STATIC
    check_build.cpp
)

target_include_directories(sharewave_core PUBLIC
    ${CMAKE_SOURCE_DIR}/include
)

target_link_libraries(sharewave_core PUBLIC
    Boost::headers
    OpenSSL::SSL
    OpenSSL::Crypto
    libsodium::libsodium
)
