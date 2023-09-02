#! /bin/sh

OUTFILE=$1/etc/tmux.conf
echo "set -g mouse on" > $OUTFILE
echo 'set -g allow-rename off' >> $OUTFILE
echo 'set -g status-right "%H:%M [#(/bin/hostname)]"' >> $OUTFILE

echo "#! /bin/sh
NAME=\${USER} 
INSTANCE=\`tmux ls | grep \${NAME}\`

if [ -z "\"\$INSTANCE\"" ]; then
    echo "starting new session"
    tmux new-session -s \${NAME}
else
    echo "resume session"
    tmux attach-session -t \${NAME}
fi" > $1/bin/startmux
chmod 755 $1/bin/startmux
