#!/usr/bin/with-contenv /bin/bash
set -e

[ -e /etc/tinc/${TINC_NETWORK} ] || mkdir -p /etc/tinc/${TINC_NETWORK}
find /etc/tinc/${TINC_NETWORK}-config/configs/${TINC_HOSTNAME} -mindepth 1 -maxdepth 3 | while read -r filename; do
    destination=/etc/tinc/${TINC_NETWORK}/$(basename ${filename})
    cp ${filename} ${destination}
done
cp -r /etc/tinc/${TINC_NETWORK}-config/hosts /etc/tinc/${TINC_NETWORK}

chmod 600 /etc/tinc/${TINC_NETWORK}/*.priv