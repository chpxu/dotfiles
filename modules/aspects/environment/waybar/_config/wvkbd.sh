#!/bin/sh

# This script causes the Waybar custom/keyboard module to check if wvkbd-mobintl process is running.  If it is running, then kill it. If it isn't running execute. Otherwise do nothing.

# Store output of command
OUTPUT=$(pgrep 'wvkbd-mobintl')
echo -e $OUTPUT
# Check if it returns a number. If it does, kill it. Else start it.
case $OUTPUT in
  ''|*[!0-9]*) exec wvkbd-mobintl ;;
  *) exec pkill -f wvkbd-mobintl;;
esac

echo 'f'