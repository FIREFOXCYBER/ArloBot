#!/usr/bin/env bash

# Grab and save the path to this script
# http://stackoverflow.com/a/246128
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPTDIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
# echo ${SCRIPTDIR} # For debugging

export NVM_DIR="${HOME}/.nvm"
# shellcheck source=/home/chrisl8/.nvm/nvm.sh
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
source ${SCRIPTDIR}/setNodeVersion.sh
nvm use ${node_version}
cd ${SCRIPTDIR}/../node
forever start --killSignal=SIGINT --minUptime=5000 --spinSleepTime=10000 --l="/tmp/robotNodeScript.log" --o="/tmp/robotNodeScript.log" --e="/tmp/robotNodeScript.log" index.js
forever list
firefox http://localhost:8080/ &>/dev/null
forever stop index.js
rm "/tmp/robotNodeScript.log"
