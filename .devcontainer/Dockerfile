FROM registry.fedoraproject.org/fedora:44

RUN dnf clean all \
    && dnf -y install \
        bash-completion \
        git \
        gh \
        python3 \
        python3-pip \
        ShellCheck \
        sudo \
        shadow-utils \
    && dnf clean all

RUN useradd --create-home --shell /bin/bash vscode \
    && printf 'vscode ALL=(ALL) NOPASSWD: ALL\n' > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

USER vscode
