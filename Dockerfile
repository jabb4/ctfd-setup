FROM python:3.11-slim-bookworm AS build

WORKDIR /opt/CTFd

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        libffi-dev \
        libssl-dev \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"



# Install CTFd and dependencies
RUN git clone https://github.com/CTFd/CTFd.git .
RUN pip install --no-cache-dir -r requirements.txt

# Install plugins and thier dependencies
# RUN git clone https://github.com/jabb4/CTFd-Docker-Plugin.git CTFd/plugins/CTFd-Docker-Plugin
# RUN pip install --no-cache-dir -r CTFd/plugins/CTFd-Docker-Plugin/requirements.txt

# Install themes
# RUN git clone ....... CTFd/themes

# Apply custom css
COPY custom-css CTFd/custom-css
RUN chmod +x CTFd/custom-css/apply.sh
WORKDIR /opt/CTFd/CTFd/custom-css
RUN ./apply.sh




FROM python:3.11-slim-bookworm AS release
WORKDIR /opt/CTFd

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libffi8 \
        libssl3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --chown=1001:1001 --from=build /opt/CTFd /opt/CTFd

RUN useradd \
    --no-log-init \
    --shell /bin/bash \
    -u 1001 \
    ctfd \
    && mkdir -p /var/log/CTFd /var/uploads \
    && chown -R 1001:1001 /var/log/CTFd /var/uploads /opt/CTFd \
    && chmod +x /opt/CTFd/docker-entrypoint.sh

COPY --chown=1001:1001 --from=build /opt/venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

USER 1001
EXPOSE 8000
ENTRYPOINT ["/opt/CTFd/docker-entrypoint.sh"]
