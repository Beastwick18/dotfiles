#!/bin/bash

# Try to start discord only if it is not currently runnign
ps cax | grep Discord > /dev/null
if [ $? -ne 0 ]; then
    Discord --start-minimized &
else
    echo ruh roh
fi
