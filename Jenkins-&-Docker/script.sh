#!/bin/bash

NAME=$1
LAST_NAME=$2
SHOW=$3

if [ "$SHOW" = "true" ]; then
  echo "Hello, $NAME $LAST_NAME!"
else
  echo "If you want to see the name, set true"
fi