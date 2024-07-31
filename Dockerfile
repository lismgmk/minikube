FROM n8nio/n8n:latest

RUN mkdir -p /home/node/.n8n/nodes
RUN npm install --prefix /home/node/.n8n/nodes n8n-nodes-browserless
