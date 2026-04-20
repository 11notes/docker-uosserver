# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
# GLOBAL
  ARG APP_UID=1000 \
      APP_GID=1000 \
      APP_VERSION=0

  # :: FOREIGN IMAGES
  FROM 11notes/distroless:localhealth AS distroless-localhealth


# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
# :: UOSSERVER MODIFICATIONS
  FROM 11notes/uosserver:fw-${APP_VERSION} AS build
  COPY ./rootfs /
  ARG APP_VERSION \
      TARGETARCH \
      TARGETVARIANT

  RUN set -eux; \
    echo "UOSSERVER.0000000.${APP_VERSION}.0000000.000000.0000" > /usr/lib/version; \
    case "${TARGETARCH}${TARGETVARIANT}" in \
      "amd64") echo "linux-x64" > /usr/lib/platform;; \
      "arm64") echo "arm64" > /usr/lib/platform;; \
    esac;

  RUN set -eux; \
    chmod +x -R /usr/local/bin;


# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
# :: HEADER
  FROM scratch

  # :: default arguments
    ARG TARGETPLATFORM \
        TARGETOS \
        TARGETARCH \
        TARGETVARIANT \
        APP_IMAGE \
        APP_NAME \
        APP_VERSION \
        APP_ROOT \
        APP_UID \
        APP_GID \
        APP_NO_CACHE

  # :: default environment
    ENV APP_IMAGE=${APP_IMAGE} \
        APP_NAME=${APP_NAME} \
        APP_VERSION=${APP_VERSION} \
        APP_ROOT=${APP_ROOT}

  # :: multi-stage
    COPY --from=distroless-localhealth / /
    COPY --from=build / /

# :: PERSISTENT DATA
  VOLUME ["/persistent", "/data", "/srv", "/var/lib/unifi", "/var/lib/mongodb", "/etc/rabbitmq/ssl"]

# :: MONITORING
  HEALTHCHECK --interval=5s --timeout=2s --start-period=60s \
    CMD ["/usr/local/bin/localhealth", "https://127.0.0.1:443/", "-I"]

# :: EXECUTE
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]