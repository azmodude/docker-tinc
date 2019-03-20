FROM phusion/baseimage as builder

# Install build dependencies
RUN set -x && \
    apt-get update && \
    apt-get -y install build-essential libncurses5-dev libreadline-dev libzlcore-dev \
    zlib1g-dev liblzo2-dev libssl-dev curl
# Build tinc
ARG TINC_VERSION
RUN curl -O https://www.tinc-vpn.org/packages/tinc-${TINC_VERSION}.tar.gz && \
    tar xfz tinc-${TINC_VERSION}.tar.gz && \
    cd tinc-${TINC_VERSION} && \
    ./configure && make install



FROM phusion/baseimage
LABEL maintainer="Gordon Schulz <gordon.schulz@gmail.com>"

# Install runtime dependencies
RUN set -x && \
  apt-get update && \
  apt-get -y install openssl liblzo2-2 libncurses5 libreadline6 zlib1g \
  iputils-ping iputils-tracepath iproute2 bash && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Copy tinc from builder over
COPY --from=builder /usr/local/sbin/tinc* /sbin/
# Copy rootfs into image
COPY rootfs /

CMD ["/sbin/my_init"]
