FROM jlesage/baseimage-gui:ubuntu-22.04-v4

LABEL maintainer="carvajal.diego@gmail.com"

# Update and Add mediaelch Repo
RUN apt-get update && \
    apt-get -y --no-install-recommends install software-properties-common gpg-agent binutils && \
    rm -rf /var/lib/apt/lists/* && \
    add-apt-repository ppa:mediaelch/mediaelch-stable

# Install mediaelch
RUN apt-get update && \
    apt-get -y --no-install-recommends install mediaelch && \
    rm -rf /var/lib/apt/lists/*

# Locale
ENV LANG=es_ES.UTF-8
RUN apt-get update && \
    apt-get -y --no-install-recommends install locales && \
    locale-gen en_US.UTF-8 && \
    locale-gen es_ES.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

# FIX libQt5Core.so.5 in docker 
RUN strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

# Define Run
ENV APP_NAME="mediaelch"
COPY startapp.sh /startapp.sh