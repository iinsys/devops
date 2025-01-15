#!/bin/bash

simulate_disk_usage() {
  echo "Simulating low disk space by creating dummy files..."
  dd if=/dev/zero of=/tmp/dummy_file bs=1M count=50000
  echo "Dummy files created. Disk space usage increased."
}
