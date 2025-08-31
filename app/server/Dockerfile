# ----------- Build Stage -------------
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# ----------- Runtime Stage -------------
FROM node:20-alpine

WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app /app
USER appuser

CMD ["node", "server.js"]







