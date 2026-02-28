FROM node:20-alpine

WORKDIR /app

# Kopírovat package files
COPY package*.json ./

# Instalovat dependencies
RUN npm install --omit=dev

# Kopírovat zbytek aplikace
COPY . .

# Expose port
EXPOSE 3003

# Healthcheck - používá wget místo node (jednodušší)
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3003/manifest.json || exit 1

# Spustit aplikaci
CMD ["node", "server.js"]
