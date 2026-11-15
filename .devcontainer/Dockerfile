FROM debian:13.7

RUN apt-get update && apt-get install -y \
    clang \
    cmake \
    git \
    libc++-dev \
    libc++abi-dev \
    ninja-build \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages conan
