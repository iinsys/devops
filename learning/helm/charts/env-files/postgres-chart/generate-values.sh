# generate-values.sh
# Converts .env to values.yaml format
awk -F= '{print tolower($1) ": \"" $2 "\""}' .env > values-secrets.yaml
