#!/usr/bin/env bash
set -e

export DISPLAY=:1
export PORT="${PORT:-10000}"

if [ -f /usr/share/novnc/vnc.html ] && [ ! -f /usr/share/novnc/index.html ]; then
  ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html
fi

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
