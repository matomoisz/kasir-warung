# Simple Dockerfile for Kasir Warung
FROM node:18-alpine

WORKDIR /app

# install dependencies
COPY package*.json ./
RUN npm install --production

# copy app
COPY . .

# ensure data file directory exists
RUN mkdir -p /app

ENV PORT=3000
EXPOSE 3000

CMD ["node", "app.js"]
