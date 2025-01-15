#!/bin/bash
cleanup_tmp() {
  echo "Cleaning temporary files..."
  find /tmp -type f -mtime +1 -exec rm -f {} \;
  echo "Temporary files cleaned."
}
