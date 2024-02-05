#!/bin/bash

source "./script/config.sh"

main()
{
    flag=0
    echo "start to test all binary file" && echo

    for i in ${bin_list[@]}; do
        if [ -f "${bin_path}/$i" ]; then
            echo "=== $i exist ==="
        else
            echo "=== $i not exist ===" && flag=`expr $flag + 1`
        fi
    done

    if [ $flag == 0 ]; then
        echo && echo "all test successful"
    else
        echo && echo "some test failed ($flag)"
    fi
}

main
