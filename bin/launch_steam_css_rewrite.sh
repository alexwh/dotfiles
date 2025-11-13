#!/usr/bin/env bash
grep -q 'height:324px' ~/.steam/steam/steamui/css/chunk\~2dcc5aaf7.css && \
    cp ~/.steam/steam/steamui/css/chunk\~2dcc5aaf7.css{,.bak} && \
    sed -i 's/height:324px/display:none/g' ~/.steam/steam/steamui/css/chunk\~2dcc5aaf7.css && \
    sed -zi 's/...$//' ~/.steam/steam/steamui/css/chunk\~2dcc5aaf7.css

/usr/bin/steam -noverifyfiles -silent $@
