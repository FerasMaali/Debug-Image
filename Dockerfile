FROM ubuntu:24.04

# Install minimal essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    busybox \
    curl \
    ca-certificates \
    git \
    vim \
    wget \
    moreutils \
    && rm -rf /var/lib/apt/lists/*

# Install go-task for on-demand installations
RUN curl -sL https://taskfile.dev/install.sh | sh -s -- -b /usr/local/bin

# Enable bash completion for task
RUN task --completion bash > /etc/bash_completion.d/task

# Copy Taskfile
COPY Taskfile.yml /root/Taskfile.yml

# Copy welcome scripts
COPY welcome.sh /usr/local/bin/welcome.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/welcome.sh /usr/local/bin/entrypoint.sh

WORKDIR /root
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]