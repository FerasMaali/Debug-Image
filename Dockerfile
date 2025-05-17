FROM ubuntu:24.04

# Avoid any interactive prompts while using apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Update and upgrade packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        apt-transport-https \
        build-essential \
        curl \
        dnsutils \
        gdb \
        git \
        gnupg \
        gzip \
        htop \
        iftop \
        iotop \
        iproute2 \
        iputils-ping \
        jq \
        lsb-release \
        moreutils \
        netcat-traditional \
        net-tools \
        nmap \
        python3 \
        python3-pip \
        rar \
        strace \
        tcpdump \
        tcptraceroute \
        telnet \
        tmux \
        traceroute \
        unrar \
        unzip \
        vim \
        wget \
        xz-utils \
        zip \
    && rm -rf /var/lib/apt/lists/*

# Install amix/vimrc
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime \
    && sh ~/.vim_runtime/install_awesome_vimrc.sh

# Install ASDF
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3 \
    && echo ". \"\$HOME/.asdf/asdf.sh\"" >> ~/.bashrc \
    && echo ". \"\$HOME/.asdf/completions/asdf.bash\"" >> ~/.bashrc

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install mssql tools
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
        | gpg --dearmor \
        > /usr/share/keyrings/microsoft-prod.gpg \
    && curl -fsSL https://packages.microsoft.com/config/ubuntu/24.04/prod.list \
        > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y --no-install-recommends \
        msodbcsql18 \
        mssql-tools18 \
        unixodbc-dev \
    && ln -s /opt/mssql-tools18/bin/sqlcmd /usr/local/bin/sqlcmd \
    && ln -s /opt/mssql-tools18/bin/bcp /usr/local/bin/bcp \
    && rm -rf /var/lib/apt/lists/*

# Install SqlPackage (DacFx CLI)
RUN apt-get update \
    && apt-get install -y --no-install-recommends libunwind8 \
    && curl -L https://aka.ms/sqlpackage-linux -o sqlpackage.zip \
    && mkdir /opt/sqlpackage \
    && unzip sqlpackage.zip -d /opt/sqlpackage \
    && chmod a+x /opt/sqlpackage/sqlpackage \
    && ln -s /opt/sqlpackage/sqlpackage /usr/local/bin/sqlpackage \
    && rm sqlpackage.zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

CMD ["/bin/bash"]
