# Official Dockerfile for professoroakz/.github
# GitHub configuration repository package
FROM alpine:3.18

# Build arguments for versioning
ARG VERSION=1.3.37
ARG BUILD_DATE
ARG VCS_REF

# OCI Container Image labels (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.title="professoroakz/.github" \
      org.opencontainers.image.description="Official GitHub configuration repository containing profile settings, workflows, and project configurations." \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.source="https://github.com/professoroakz/.github" \
      org.opencontainers.image.url="https://github.com/professoroakz/.github" \
      org.opencontainers.image.documentation="https://github.com/professoroakz/.github#readme" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="professoroakz" \
      org.opencontainers.image.authors="professoroakz"

# Set environment variables
ENV APP_VERSION=${VERSION} \
    APP_HOME=/app

# Create non-root user for security
RUN addgroup -g 1000 appgroup && \
    adduser -u 1000 -G appgroup -h /app -D appuser

# Copy repository contents
COPY --chown=appuser:appgroup . ${APP_HOME}

# Set working directory
WORKDIR ${APP_HOME}

# Switch to non-root user
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD test -f /app/VERSION || exit 1

# Default command - provide an interactive shell
CMD ["/bin/sh"]
