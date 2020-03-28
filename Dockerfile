FROM arm32v7/debian:stable-slim
MAINTAINER Brian Boerst

CMD ["bash"]

ENV LANG=C.UTF-8
ARG SABNZBD_VERSION=2.3.9

ADD sabnzbd.sh /sabnzbd.sh

RUN export DEBIAN_FRONTEND=noninteractive && \
    groupadd -r -g 666 sabnzbd && \
    useradd -l -r -u 666 -g 666 -d /sabnzbd sabnzbd && \
    chmod 755 /sabnzbd.sh && \
    apt-get -q update && \
    apt-get install -qqy python python-cheetah python-sabyenc python-cryptography par2 unrar-free p7zip-full unzip openssl python-openssl ca-certificates curl && \
    curl -SL --insecure -o /tmp/sabnzbd.tar.gz https://github.com/sabnzbd/sabnzbd/releases/download/${SABNZBD_VERSION}/SABnzbd-${SABNZBD_VERSION}-src.tar.gz && \
    tar xzf /tmp/sabnzbd.tar.gz && \
    mv SABnzbd-* sabnzbd && \
    chown -R sabnzbd: sabnzbd && \
    apt-get -y remove --purge curl && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME [/datadir /media]
EXPOSE 8080

WORKDIR /sabnzbd
CMD ["/sabnzbd.sh"]