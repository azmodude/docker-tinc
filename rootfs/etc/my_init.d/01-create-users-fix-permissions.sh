#!/bin/bash

>&2 echo "Adding tincd with UID ${RUN_UID}"
groupadd --system tincd || true && \
    useradd -K MAIL_DIR=/tmp -c 'Run User' -s /bin/bash -m -g tincd \
    -u "${RUN_UID}" tincd || true
>&2 echo "fixing and setting permissions"
chown -R tincd:tincd /etc/tinc/"${TINC_NETWORK}"
chmod 700 /etc/tinc/"${TINC_NETWORK}"
