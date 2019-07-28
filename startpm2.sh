#!/usr/bin/env bash
export NVM_DIR="${HOME}/.nvm"
# shellcheck source=/home/chrisl8/.nvm/nvm.sh
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# USB Relay Controller
if [[ "$(jq '.useUSBrelay' "${HOME}"/.arlobot/personalDataForBehavior.json)" == true ]]; then
  echo "Turning off all relays"
  "${HOME}"/catkin_ws/src/ArloBot/scripts/switch_relay_name.sh all off
fi

# Master Power Relay
if [[ "$(jq '.useMasterPowerRelay' "${HOME}"/.arlobot/personalDataForBehavior.json)" == true ]]; then
  echo "Turning off Arlo Power."

  # It takes a while before it works after boot up.
  while ! "${HOME}"/catkin_ws/src/ArloBot/scripts/switch_master_relay.sh off; do
    sleep 1
    "${HOME}"/catkin_ws/src/ArloBot/scripts/switch_master_relay.sh off
  done
  # The first one always results in some odd output and a failure, so do it one more time.
  sleep 1
  "${HOME}"/catkin_ws/src/ArloBot/scripts/switch_master_relay.sh off
fi

if [[ "$(jq '.useMyCroft' "${HOME}"/.arlobot/personalDataForBehavior.json)" == true ]]; then
  cd "${HOME}"/catkin_ws/src/ArloBot/mycroft-core || exit 1
  ./start-mycroft.sh all
fi

cd "${HOME}"/catkin_ws/src/ArloBot/node/ || exit 1
"${HOME}"/.nvm/current/bin/pm2 start "${HOME}"/catkin_ws/src/ArloBot/node/pm2Config.json
