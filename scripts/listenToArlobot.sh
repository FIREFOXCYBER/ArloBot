#!/usr/bin/env bash
ssh arlobot 'pkill avconv'
ssh arlobot '/home/chrisl8/catkin_ws/src/ArloBot/scripts/streamAudioInBackground.sh' >/dev/null
echo "Run 'quit' to exit VLC and close audio stream."
echo "The audio has a significant delay, but it is steady."
echo ''
vlc -q rtp://234.5.5.5:1234
ssh arlobot 'pkill avconv'
