# Stage 1 : installation des dépendances de production uniquement
FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

# Stage 2 : image finale légère sans cache npm ni outils de build
FROM node:20-alpine AS runner

LABEL org.opencontainers.image.title="shoplite-api"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.description="ShopLite API - TP Final DevOps"

WORKDIR /app

ENV NODE_ENV=production
ENV API_PORT=3000

COPY --from=deps /app/node_modules ./node_modules
COPY src ./src

USER node

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD wget -qO- http://127.0.0.1:3000/health || exit 1

CMD ["node", "src/server.js"]
