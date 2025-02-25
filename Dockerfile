FROM openjdk:17-jdk-buster

ARG FAN_VERSION=fantom-1.0.78
ARG FAN_TAG=v1.0.78
ARG FAN_WEBDIR=https://github.com/fantom-lang/fantom/releases/download

WORKDIR /opt/

RUN set -e; \
    FAN_BIN_URL="$FAN_WEBDIR/$FAN_TAG/$FAN_VERSION.zip" \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -q update && apt-get -q install -y curl && rm -rf /var/lib/apt/lists/* \
    # Download Fantom
    && curl -fsSL "$FAN_BIN_URL" -o fantom.zip \
    # Unpack, set permissions, and clean up
    && unzip fantom.zip \
    # This will unzip to FAN_VERSION
    && chmod +x $FAN_VERSION/bin/* \
    && rm -rf fantom.zip \
    && apt-get purge --auto-remove -y curl

ENV PATH $PATH:/opt/$FAN_VERSION/bin

# Return Fantom's version
CMD ["fan","-version"]