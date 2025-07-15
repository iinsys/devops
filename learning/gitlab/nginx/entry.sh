#!/bin/bash
echo "Attempting to write to settings.json..."
echo "{\"key\":\"value\"}" > /usr/share/nginx/html/assets/settings.json
echo "Done."
exec nginx -g "daemon off;"
