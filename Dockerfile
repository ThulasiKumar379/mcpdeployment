FROM node:18-alpine

# Install kubectl
RUN apk add --no-cache curl bash \
 && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
 && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
 && rm kubectl

# Set working directory
WORKDIR /app

# Copy backend (includes frontend inside backend)
COPY backend/ ./backend
COPY backend/frontend ./backend/frontend

# Install backend dependencies
WORKDIR /app/backend
RUN npm install --production --silent

EXPOSE 8080

CMD ["node", "server.js"]

