
# Use an official Node.js image with the latest patches (minimal image)
FROM node:24.5.0-bookworm-slim

# Update package manager and upgrade installed packages to get patched versions
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Use specific working directory
WORKDIR /app

# Set a specific npm version (if needed)
RUN npm install -g npm@9.1.3

# Copy only necessary files (smaller image & layer optimization)
COPY package.json ./
COPY index.js ./
COPY build ./build

# Install dependencies
RUN npm install --omit=dev

# Only expose necessary port
EXPOSE 8080

# Use non-root user for security (optional but recommended)
RUN useradd -m appuser
USER appuser

# Run the app
CMD [ "node", "index.js" ]
