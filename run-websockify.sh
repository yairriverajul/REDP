#!/usr/bin/env bash
set -e
exec /usr/bin/websockify --web=/usr/share/novnc 0.0.0.0:${PORT} 127.0.0.1:5900
