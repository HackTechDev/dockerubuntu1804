ARG image=ubuntu:18.04
FROM $image as system


ARG localbuild
RUN echo "LOCALBUILD=$localbuild"
RUN if [ "x$localbuild" != "x" ]; then sed -i 's#http://archive.ubuntu.com/#http://fr.archive.ubuntu.com/#' /etc/apt/sources.list; fi

ENV HOME=/root \
      APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
      DEBIAN_FRONTEND=noninteractive \
      FILES='' \
      LANG=en_US.UTF-8 \
      LANGUAGE=en_US.UTF-8 \
      LC_ALL=C.UTF-8


# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl \
    && apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        mc screen vim \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*
