# polybar-msg cmd quit
killall -q polybar

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar kagami 2>&1 | tee -a /tmp/polybar1.log & disown
