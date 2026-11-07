#!/bin/bash
set -e

cd /workspaces/ShareWave
conan install . --build=missing -s build_type=Debug --profile:host=profiles/clang --profile:build=profiles/clang -o "boost/*:without_cobalt=True"
