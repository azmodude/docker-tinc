#!/usr/bin/with-contenv /bin/bash

>&2 echo "Adding ${RUN_USER} with UID ${RUN_UID} and Group ${RUN_GROUP} with GID ${RUN_GID}."
groupadd -g $RUN_GID $RUN_GROUP || true && \
    useradd -c 'Run User' -s /bin/bash -m -g $RUN_GID -u $RUN_UID $RUN_USER || true
>&2 echo "Fixing/Setting permissions."
chown -R ${RUN_USER}:${RUN_GROUP} /etc/tinc/${TINC_NETWORK}
chmod 700 /etc/tinc/${TINC_NETWORK}