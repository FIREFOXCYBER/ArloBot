#!/usr/bin/env bash

pgrep -f robot.launch >/dev/null
if [[ $? -eq 0 ]]; then
  export ROS_HOSTNAME=$(uname -n)
  export ROS_MASTER_URI=http://localhost:11311
  export ROSLAUNCH_SSH_UNKNOWN=1
  source ~/catkin_ws/devel/setup.bash
  rosrun tf tf_echo /map /base_link
else
  echo "Robot must be running to start this."
  exit 1
fi
