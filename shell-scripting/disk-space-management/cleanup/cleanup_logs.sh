#!/bin/bash
cleanup_logs() {
  echo "Cleaning old logs..."
  find /var/log -type f -name "*.log" -mtime +7 -exec rm -f {} \;
  echo "Old logs cleaned."
}
