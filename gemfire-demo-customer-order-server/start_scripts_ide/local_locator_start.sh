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
name=locator_pulse
port=10334
jmxport=1099
jmxhttpport=7070
workingdir=$SCRIPTPATH/../target/test-working-dir
databrowser=http://localhost:$jmxhttpport/pulse

# start GemFire instances
echo "Starting Locator ..."
status=`(gfsh \
-e "set variable --name=LOCATOR_NAME --value=$name" \
-e "set variable --name=LOCATOR_PORT --value=$port" \
-e "set variable --name=JMX_PORT --value=$jmxport" \
-e "set variable --name=JMX_HTTP_PORT --value=$jmxhttpport" \
-e "set variable --name=WORKING_DIR --value=$workingdir" \
-e "run --file=$SCRIPTPATH/scripts/start_basic_locator.gfsh")`

echo ""
echo "** Locator Started **"
echo "* Port              : $port"
echo "* DataBrowser       : $databrowser"
echo "* Log location      : $workingdir"

tail -f $workingdir/$name.log

