#!/usr/bin/env bash
set -euo pipefail

pushd /root/Open3D
mkdir build
pushd build

# Configure
cmake -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_LIBREALSENSE=ON \
      -DBUILD_CUDA_MODULE=ON \
      -DCUDA_ARCH=BasicPTX \
      -DBUILD_TENSORFLOW_OPS=OFF \
      -DBUILD_PYTORCH_OPS=OFF \
      -DBUILD_RPC_INTERFACE=OFF \
      -DCMAKE_INSTALL_PREFIX=/root/open3d_install \
      -DPYTHON_EXECUTABLE=$(command -v python) \
      -DBUILD_UNIT_TESTS=ON \
      -DBUILD_BENCHMARKS=ON \
      -DBUILD_EXAMPLES=ON \
      ..

# Build
make -j$(nproc)

# Test
./bin/tests --gtest_filter="-*Sum*"

popd
popd