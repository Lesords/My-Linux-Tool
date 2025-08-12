#!/bin/bash

source ./script/config.sh

dst_path="$HOME/.local/bin"
dst_lib_path="$HOME/.local/lib"
dst_mihomo_path="$HOME/.config/mihomo"

[ ! -d ${dst_path} ] && mkdir -p ${dst_path}
[ ! -d ${dst_lib_path} ] && mkdir -p ${dst_lib_path}
[ ! -d ${dst_mihomo_path} ] && mkdir -p ${dst_mihomo_path}

echo "=== start to copy file ==="

if type rsync >/dev/null 2>&1; then
    rsync -av ${bin_path}/* ${dst_path}
    rsync -av ${lib_path}/* ${dst_lib_path}
    rsync -av ${config_path}/*.mmdb ${dst_mihomo_path}
else
    cp -rf ${bin_path}/* ${dst_path}
    cp -rf ${lib_path}/* ${dst_lib_path}
    cp -rf ${config_path}/*.mmdb ${dst_mihomo_path}
fi

if [ $? -eq 0 ]; then
    echo "=== All files copied successfully ==="
else
    echo "=== some files copied failed ==="
fi
