#!/usr/bin/with-contenv /bin/bash

>&2 echo "adding tincd with UID ${RUN_UID} and group tincd with GID ${RUN_GID}"
groupadd -g "${RUN_GID}" tincd || true && \
    useradd -K MAIL_DIR=/tmp -c 'Run User' -s /bin/bash -m -g "${RUN_GID}" \
    -u "${RUN_UID}" tincd || true
>&2 echo "fixing and setting permissions"
chown -R tincd:tincd /etc/tinc/"${TINC_NETWORK}"
chmod 700 /etc/tinc/"${TINC_NETWORK}"
