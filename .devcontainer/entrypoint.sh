#!/bin/bash
set -e

cd /workspaces/ShareWave
conan profile detect --force
conan config install conan/settings_user.yml
conan install . --build=missing --output-folder=build/clang --profile=profiles/clang-debug -o "boost/*:without_cobalt=True"
cmake --preset clang-debug
