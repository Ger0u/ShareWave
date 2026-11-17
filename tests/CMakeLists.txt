find_package(GTest REQUIRED)

add_executable(sharewave_unit_tests
    unit/test_check_build.cpp
)

target_link_libraries(sharewave_unit_tests PRIVATE
    sharewave_core
    GTest::gtest_main
)

# add_executable(sharewave_integration_tests

# )

# target_link_libraries(sharewave_integration_tests PRIVATE
#     sharewave_core
#     GTest::gtest_main
# )

include(GoogleTest)

gtest_discover_tests(sharewave_unit_tests
    PROPERTIES LABELS "unit"
)

# gtest_discover_tests(sharewave_integration_tests
#     PROPERTIES LABELS "integration"
# )
