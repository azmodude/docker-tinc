FROM azmo/base:debian
LABEL maintainer "Gordon Schulz <gordon.schulz@gmail.com>"

RUN echo "deb http://deb.debian.org/debian experimental main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get -t experimental -y install --no-install-recommends tinc && \
    apt-get -y install --no-install-recommends iproute2 iputils-ping && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY setup/00-link-tinc-files-per-host.sh /etc/cont-init.d/
COPY setup/01-create-users-fix-permissions.sh /etc/cont-init.d/
COPY bin/tinc.sh /etc/services.d/tincd/run
COPY healthcheck/healthcheck.sh /etc/services.d/tincd/healthcheck
