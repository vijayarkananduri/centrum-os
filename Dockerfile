# Centrum OS — Complete Development Environment
# Multi-stage build for maximum compatibility

FROM alpine:3.19 as builder

RUN apk add --no-cache \
    bash \
    curl \
    git \
    sed \
    gawk \
    grep \
    findutils

WORKDIR /build
COPY . .

RUN chmod +x ./install.sh && \
    bash ./install.sh

FROM alpine:3.19

RUN apk add --no-cache \
    bash \
    curl \
    git \
    neovim \
    tmux \
    fzf \
    sed \
    gawk \
    grep \
    findutils

COPY --from=builder /root/.centrum /root/.centrum
COPY --from=builder /root/.local /root/.local

WORKDIR /work
ENV PATH="/root/.local/bin:/root/.local/lib/centrum:$PATH"

RUN echo '#!/bin/sh' > /etc/profile.d/centrum.sh && \
    echo 'export PATH="/root/.local/bin:/root/.local/lib/centrum:$PATH"' >> /etc/profile.d/centrum.sh && \
    chmod +x /etc/profile.d/centrum.sh

ENTRYPOINT ["bash"]
CMD ["--login"]
