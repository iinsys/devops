#!/bin/bash

alert_admin() {
  local message="Disk space critical on $(hostname). Manual intervention required."
  echo "$message" | mail -s "Disk Space Alert" tandapnoelbansikah@gmail.com
  echo "Alert sent to admin."
}
