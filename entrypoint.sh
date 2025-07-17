#!/bin/bash

# Show welcome message only for interactive sessions
if [ -t 0 ] && [ "$#" -eq 0 ]; then
    /usr/local/bin/welcome.sh
fi

# If no command provided, start bash
if [ "$#" -eq 0 ]; then
    exec /bin/bash
else
    exec "$@"
fi