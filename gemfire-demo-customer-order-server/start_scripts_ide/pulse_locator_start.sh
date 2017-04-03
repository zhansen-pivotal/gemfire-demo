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
-e "set variable --name=LOCATOR_NAME --value=locator_pulse" \
-e "set variable --name=LOCATOR_PORT --value=10334" \
-e "set variable --name=JMX_PORT --value=1099" \
-e "set variable --name=JMX_HTTP_PORT --value=7070" \
-e "set variable --name=WORKING_DIR --value=$SCRIPTPATH/../target/test-working-dir" \
-e "run --file=$SCRIPTPATH/scripts/start_basic_locator.gfsh")
