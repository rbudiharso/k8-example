FROM node:carbon-alpine
WORKDIR /usr/app
COPY package*.json ./
RUN npm install --production
COPY . .
EXPOSE 8080
CMD ["node", "index.js"]
