#!/bin/bash

monitor_disk() {
  echo "Current Disk Usage:"
  df -h
  USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
  echo "Disk usage for / is at ${USAGE}%."
  if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "Warning: Disk usage is above the threshold of $THRESHOLD%."
  fi
}
