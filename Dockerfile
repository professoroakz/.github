# Simple Dockerfile for .github repository
FROM alpine:3.18

LABEL org.opencontainers.image.source="https://github.com/professoroakz/.github"
LABEL org.opencontainers.image.description=".github repository configuration"
LABEL org.opencontainers.image.licenses="MIT"

# Copy repository contents
COPY . /app

WORKDIR /app

# Default command - provide a shell for interactive use
CMD ["/bin/sh"]
