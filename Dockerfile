#ubuntu:16.04 may cause network problem in china
FROM ubuntu:xenial
WORKDIR /ardupilot

RUN useradd -U -d /ardupilot ardupilot && \
    usermod -G users ardupilot

# there might be a error: "error creating new backup file '/var/lib/dpkg/status-old'"
# refer to https://gist.github.com/Francesco149/ce376cd83d42774ed39d34816b9e21db
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install --no-install-recommends -y \
    lsb-release \
    sudo \
    software-properties-common \
    python-software-properties && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV USER=ardupilot
ADD . /ardupilot
RUN chown -R ardupilot:ardupilot /ardupilot && \
    bash -c "Tools/scripts/install-prereqs-ubuntu.sh -y && apt-get install gcc-arm-none-eabi -y" && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER ardupilot

RUN pip install MAVProxy pymavlink

ENV CCACHE_MAXSIZE=1G
ENV PATH /usr/lib/ccache:/ardupilot/Tools:/ardupilot/Tools/autotest:/ardupilot/.local/bin:${PATH}
