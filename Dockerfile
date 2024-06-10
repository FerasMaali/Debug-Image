FROM ubuntu:22.04

# Avoid any interactive prompts while using apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages
RUN apt-get update && apt-get upgrade -y

# Install debugging and necessary tools
RUN apt-get install -y \
    build-essential \
    curl \
    dnsutils \
    gdb \
    git \
    gzip \
    htop \
    iftop \
    iotop \
    iproute2 \
    iputils-ping \
    jq \
    moreutils \
    net-tools \
    netcat \
    nmap \
    python3 \
    python3-pip \
    rar \
    strace \
    tcpdump \
    telnet \
    tmux \
    unrar \
    unzip \
    vim \
    wget \
    xz-utils \
    zip

# Install amix/vimrc
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime \
    && sh ~/.vim_runtime/install_awesome_vimrc.sh

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3 \
    && echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc \
    && echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc

WORKDIR /root

CMD ["/bin/bash"]
