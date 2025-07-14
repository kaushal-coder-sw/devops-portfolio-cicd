FROM node:18-alpine

# Set working directory
WORKDIR /app

# Create a minimal package.json with express dependency
RUN echo '{ \
  "name": "devops-portfolio", \
  "version": "1.0.0", \
  "main": "server.js", \
  "scripts": { "start": "node server.js" }, \
  "dependencies": { "express": "^4.18.2" } \
}' > package.json

# Install express
RUN npm install

# Copy app code (server.js + public/index.html)
COPY . .

# Expose HTTP port
EXPOSE 80

# Start the app
CMD ["npm", "start"]

RUN npm install express

EXPOSE 80

CMD ["node", "server.js"]
