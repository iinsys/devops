FROM nginx:latest

COPY entry.sh /opt/entry.sh
COPY assets/settings.json /usr/share/nginx/html/assets/settings.json

RUN chmod 775 /opt/entry.sh \
    && chmod 644 /usr/share/nginx/html/assets/settings.json  # ← simulate error first

ENTRYPOINT ["/opt/entry.sh"]

