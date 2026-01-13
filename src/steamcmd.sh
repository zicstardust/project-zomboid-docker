#!/usr/bin/env bash

current_dir=$(pwd)

cd /opt/steamcmd

./steamcmd.sh "$@"

return_code=$?

cd $current_dir

exit $return_code