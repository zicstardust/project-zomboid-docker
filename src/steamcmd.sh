#!/usr/bin/env bash

current_dir=$(pwd)

cd /opt/steamcmd


while true; do
    ./steamcmd.sh "$@"
    #echo "Steamcmd return code: $?"
    return_code=$?
    if [ "$return_code" == "0" ]; then
        break
    else
        echo "Steamcmd error: ${return_code}, try again"
    fi  
done

return_code=$?

cd $current_dir

exit $return_code