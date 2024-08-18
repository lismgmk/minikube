ARG NODE_VERSION=18
ARG N8N_VERSION="latest"

FROM n8nio/base:${NODE_VERSION} as builder

RUN set -eux; \
    npm install -g pnpm --force

USER node


FROM n8nio/n8n:${N8N_VERSION}

# Set environment variables
ENV NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt \
    NODE_OPTIONS=--use-openssl-ca \
    N8N_ENCRYPTION_KEY="PXMuOritB2E05bOqaMuEU2hmdxbtEPE6" \
    POSTGRES_USER=n8n \
    POSTGRES_PASSWORD="password" \
    POSTGRES_DB=n8n \
    POSTGRESDB_HOST=db \
    POSTGRESDB_PORT=5432 \
    N8N_CUSTOM_NODES_PATH=/usr/src/n8n/nodes/node_modules \
    NODE_FUNCTION_ALLOW_EXTERNAL=axios \
    NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt \
    NODE_OPTIONS=--use-openssl-ca


# Ensure the right permissions and directory setup
RUN set -eux; \
    mkdir -p /home/node/.n8n/nodes; \
    cd /home/node/.n8n/nodes; \
    if [ ! -f package.json ]; then \
      echo "Init pnpm"; \
      pnpm init; \
    fi; \
    echo "Installing community nodes..."; \
    pnpm add \
      n8n-nodes-text-manipulation \
      n8n-nodes-browserless \
      n8n-nodes-json-diff \
      n8n-nodes-passwork \
      n8n-nodes-randomizer \
      n8n-nodes-yaml \
      n8n-nodes-youtrack \
      n8n-nodes-kafka-snappy \
      axios \
      axios-ntlm; \
    echo 'Community nodes installed'


# Default command
CMD ["start", "--reinstallMissingPackages"]
