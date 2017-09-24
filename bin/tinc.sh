#!/usr/bin/with-contenv /bin/bash

tincd -n "${TINC_NETWORK}" --no-detach --mlock --user=${RUN_USER} --debug=${TINC_DEBUG_LEVEL}
