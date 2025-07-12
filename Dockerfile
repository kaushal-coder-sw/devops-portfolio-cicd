FROM node:18-alpine

WORKDIR /app

COPY . .

RUN npm install express

EXPOSE 80

CMD ["node", "server.js"]
