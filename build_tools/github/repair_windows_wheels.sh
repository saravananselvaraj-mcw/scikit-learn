#!/bin/bash

set -e
set -x

WHEEL=$1
DEST_DIR=$2

# By default, the Windows wheels are not repaired.
# In this case, we need to vendor VCRUNTIME140.dll
pip install wheel
wheel unpack "$WHEEL"
WHEEL_DIRNAME=$(ls -d scikit_learn-*)
python build_tools/github/vendor.py "$WHEEL_DIRNAME"
LLVM_BIN="/c/Program Files/LLVM/bin"
cp "$LLVM_BIN/libomp.dll" "$WHEEL_DIRNAME/sklearn/.libs/" || true
wheel pack "$WHEEL_DIRNAME" -d "$DEST_DIR"
rm -rf "$WHEEL_DIRNAME"
