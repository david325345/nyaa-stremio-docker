FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY server.js ./
COPY public/ ./public/

EXPOSE 3008

HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
  CMD /bin/sh -c "wget -qO- http://localhost:${PORT:-3008}/ || exit 1"

CMD ["node", "server.js"]
