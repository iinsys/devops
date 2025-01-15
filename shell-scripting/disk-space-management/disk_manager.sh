#!/bin/bash

# Include utilities
source utils/monitor_disk.sh
source cleanup/cleanup_logs.sh
source cleanup/cleanup_tmp.sh
source cleanup/cleanup_cache.sh
source utils/alert_admin.sh
source utils/simulate_disk.sh

LOG_FILE="logs/disk_cleanup.log"
THRESHOLD=80 # Default threshold

# Function to display menu
show_menu() {
  echo "============================="
  echo " Disk Space Management System"
  echo "============================="
  echo "1. View Current Disk Usage"
  echo "2. Set Disk Usage Threshold"
  echo "3. Run Cleanup"
  echo "4. Simulate Low Disk Space"
  echo "5. Exit"
  echo "============================="
}

# Function to handle user input
handle_choice() {
  read -p "Enter your choice [1-5]: " choice
  case $choice in
    1)
      monitor_disk
      ;;
    2)
      read -p "Enter new threshold (e.g., 70 for 70%): " new_threshold
      if [[ $new_threshold =~ ^[0-9]+$ && $new_threshold -le 100 ]]; then
        THRESHOLD=$new_threshold
        echo "Threshold set to $THRESHOLD%."
      else
        echo "Invalid input. Please enter a valid percentage."
      fi
      ;;
    3)
      run_cleanup
      ;;
    4)
      simulate_disk_usage
      ;;
    5)
      echo "Exiting. Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid choice. Please try again."
      ;;
  esac
}

# Function to run cleanup
run_cleanup() {
  echo "$(date): Triggering cleanup..." >> "$LOG_FILE"
  cleanup_logs
  cleanup_tmp
  cleanup_cache
  echo "Cleanup complete. Check the logs for details."
}

# Main Loop
while true; do
  show_menu
  handle_choice
done

