# daemon runs in the background
# run something like tail /var/log/Bitcoinnovad/current to see the status
# be sure to run with volumes, ie:
# docker run -v $(pwd)/Bitcoinnovad:/var/lib/Bitcoinnovad -v $(pwd)/wallet:/home/Bitcoinnova --rm -ti Bitcoinnova:0.2.2
ARG base_image_version=0.10.0
FROM phusion/baseimage:$base_image_version

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.2/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

ADD https://github.com/just-containers/socklog-overlay/releases/download/v2.1.0-0/socklog-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/socklog-overlay-amd64.tar.gz -C /

ARG Bitcoinnova_VERSION=v0.3.0
ENV Bitcoinnova_VERSION=${Bitcoinnova_VERSION}

# install build dependencies
# checkout the latest tag
# build and install
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      python-dev \
      gcc-4.9 \
      g++-4.9 \
      git cmake \
      libboost1.58-all-dev \
      librocksdb-dev && \
    git clone https://github.com/Bitcoinnova/Bitcoinnova.git /src/Bitcoinnova && \
    cd /src/Bitcoinnova && \
    git checkout $Bitcoinnova_VERSION && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_FLAGS="-g0 -Os -fPIC -std=gnu++11" .. && \
    make -j$(nproc) && \
    mkdir -p /usr/local/bin && \
    cp src/Bitcoinnovad /usr/local/bin/Bitcoinnovad && \
    cp src/walletd /usr/local/bin/walletd && \
    cp src/simplewallet /usr/local/bin/simplewallet && \
    cp src/miner /usr/local/bin/miner && \
    cp src/connectivity_tool /usr/local/bin/connectivity_tool && \
    strip /usr/local/bin/Bitcoinnovad && \
    strip /usr/local/bin/walletd && \
    strip /usr/local/bin/simplewallet && \
    strip /usr/local/bin/miner && \
    strip /usr/local/bin/connectivity_tool && \
    cd / && \
    rm -rf /src/Bitcoinnova && \
    apt-get remove -y build-essential python-dev gcc-4.9 g++-4.9 git cmake libboost1.58-all-dev librocksdb-dev && \
    apt-get autoremove -y && \
    apt-get install -y  \
      libboost-system1.58.0 \
      libboost-filesystem1.58.0 \
      libboost-thread1.58.0 \
      libboost-date-time1.58.0 \
      libboost-chrono1.58.0 \
      libboost-regex1.58.0 \
      libboost-serialization1.58.0 \
      libboost-program-options1.58.0 \
      libicu55

# setup the Bitcoinnovad service
RUN useradd -r -s /usr/sbin/nologin -m -d /var/lib/Bitcoinnovad Bitcoinnovad && \
    useradd -s /bin/bash -m -d /home/Bitcoinnova Bitcoinnova && \
    mkdir -p /etc/services.d/Bitcoinnovad/log && \
    mkdir -p /var/log/Bitcoinnovad && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/Bitcoinnovad/run && \
    echo "fdmove -c 2 1" >> /etc/services.d/Bitcoinnovad/run && \
    echo "cd /var/lib/Bitcoinnovad" >> /etc/services.d/Bitcoinnovad/run && \
    echo "export HOME /var/lib/Bitcoinnovad" >> /etc/services.d/Bitcoinnovad/run && \
    echo "s6-setuidgid Bitcoinnovad /usr/local/bin/Bitcoinnovad" >> /etc/services.d/Bitcoinnovad/run && \
    chmod +x /etc/services.d/Bitcoinnovad/run && \
    chown nobody:nogroup /var/log/Bitcoinnovad && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/Bitcoinnovad/log/run && \
    echo "s6-setuidgid nobody" >> /etc/services.d/Bitcoinnovad/log/run && \
    echo "s6-log -bp -- n20 s1000000 /var/log/Bitcoinnovad" >> /etc/services.d/Bitcoinnovad/log/run && \
    chmod +x /etc/services.d/Bitcoinnovad/log/run && \
    echo "/var/lib/Bitcoinnovad true Bitcoinnovad 0644 0755" > /etc/fix-attrs.d/Bitcoinnovad-home && \
    echo "/home/Bitcoinnova true Bitcoinnova 0644 0755" > /etc/fix-attrs.d/Bitcoinnova-home && \
    echo "/var/log/Bitcoinnovad true nobody 0644 0755" > /etc/fix-attrs.d/Bitcoinnovad-logs

VOLUME ["/var/lib/Bitcoinnovad", "/home/Bitcoinnova","/var/log/Bitcoinnovad"]

ENTRYPOINT ["/init"]
CMD ["/usr/bin/execlineb", "-P", "-c", "emptyenv cd /home/Bitcoinnova export HOME /home/Bitcoinnova s6-setuidgid Bitcoinnova /bin/bash"]
