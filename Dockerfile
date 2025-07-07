# palworld
FROM --platform=$TARGETPLATFORM debian:bookworm-20250630-slim AS step2
ARG TARGETPLATFORM

ARG USERNAME=palworld
ARG GROUPNAME=palworld
ARG UID=1000
ARG GID=1000
ARG STEAMCMD=https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
ARG APP_NO=2394010

ENV DATA_DIR=/home/${USERNAME}/Steam/steamapps/common/PalServer

COPY . /server

RUN apt-get update && \
    apt-get install -y curl unzip lib32gcc-s1 && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip

WORKDIR /server

# download
RUN curl -o steamcmd_linux.tar.gz ${STEAMCMD} && \
    tar -xzvf steamcmd_linux.tar.gz && \
    rm -f steamcmd_linux.tar.gz && \
    mkdir -p ${DATA_DIR} && \
    /bin/bash ./steamcmd.sh +force_install_dir ${DATA_DIR} +login anonymous +app_update ${APP_NO} validate +quit

RUN groupadd -g ${GID} ${GROUPNAME} && \
    useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USERNAME} && \
    chown -R ${USERNAME} /server && \
    chown -R ${USERNAME} ${DATA_DIR}

USER ${USERNAME}

ENTRYPOINT /bin/bash /server/bin/run.sh
