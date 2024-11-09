FROM alpine:latest

RUN apk add --no-cache bash curl tar

RUN curl -L -o /tmp/proxy-linux-amd64.tar.gz https://github.com/snail007/goproxy/releases/download/v14.7/proxy-linux-amd64.tar.gz && \
    tar -xzvf /tmp/proxy-linux-amd64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/proxy && \
    rm /tmp/proxy-linux-amd64.tar.gz

RUN /usr/local/bin/proxy --version || { echo "Failed to install goproxy"; exit 1; }

WORKDIR /app
COPY ../rotator.sh /app/rotator.sh

RUN chmod +x /app/rotator.sh

ENTRYPOINT ["bash", "/app/rotator.sh"]