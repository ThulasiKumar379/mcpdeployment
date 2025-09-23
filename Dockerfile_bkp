# Stage 1: build frontend
FROM node:18-alpine AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install --silent
COPY frontend ./
RUN npm run build

# Stage 2: build backend
FROM node:18-alpine AS backend
WORKDIR /app
COPY backend/package*.json ./
RUN npm install --production --silent
COPY backend ./
# copy frontend build into backend public
COPY --from=frontend-builder /app/frontend/build ./public

ENV PORT=3000
EXPOSE 3000
CMD ["node", "index.js"]

