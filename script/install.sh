#!/bin/bash

source ./script/config.sh

dst_path="$HOME/.local/bin"

[ ! -d ${dst_path} ] && mkdir -p ${dst_path}

echo "=== start to copy file ==="

cp -rf ${bin_path}/* ${dst_path}

if [ $? -eq 0 ]; then
    echo "=== All files copied successfully ==="
else
    echo "=== some files copied failed ==="
fi
