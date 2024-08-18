
FROM n8nio/n8n:latest

USER root

RUN mkdir -p /home/node/.n8n/nodes

RUN npm install -g pnpm --force

RUN pnpm install --prefix /home/node/.n8n/nodes n8n-nodes-browserless n8n-nodes-kafka-snappy
RUN pnpm list --prefix /home/node/.n8n/nodes
USER node
