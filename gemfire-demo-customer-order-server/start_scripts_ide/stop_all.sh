#!/usr/bin/env bash

#!/bin/bash
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPTPATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
echo $SCRIPTPATH

# Run setenv to set the GemFire environment variables

# start GemFire instances
(gfsh \
-e "connect" \
-e "shutdown --include-locators=true")