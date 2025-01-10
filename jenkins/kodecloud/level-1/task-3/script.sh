#!/bin/bash

# Login credentials
ADMIN_USER="admin"
ADMIN_PASS="Adm!n321"

# Jenkins URL
JENKINS_URL="http://localhost:8080"

# Mariyam's credentials
USER_NAME="mariyam"
PASSWORD="YchZHRcLkL"
FULL_NAME="Mariyam"

# Create a Jenkins user (requires Jenkins CLI or script console)
curl -X POST "${JENKINS_URL}/securityRealm/createAccountByAdmin" \
    --user "${ADMIN_USER}:${ADMIN_PASS}" \
    --data-urlencode "username=${USER_NAME}" \
    --data-urlencode "password1=${PASSWORD}" \
    --data-urlencode "password2=${PASSWORD}" \
    --data-urlencode "fullname=${FULL_NAME}" \
    --data-urlencode "email="

echo "User 'mariyam' created successfully!"
