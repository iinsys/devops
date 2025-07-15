FROM nginx:latest

COPY entry.sh /opt/entry.sh
COPY assets/settings.json /usr/share/nginx/html/assets/settings.json

RUN chmod 775 /opt/entry.sh \
    && chmod 666 /usr/share/nginx/html/assets/settings.json \
    && chgrp -R root /var/cache/nginx \
    && chmod -R g+rwX /var/cache/nginx \
    && chmod -R g+rwX /var/run  # <-- FIX for nginx.pid permission issue

ENTRYPOINT ["/opt/entry.sh"]
