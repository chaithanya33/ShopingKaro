FROM node:18
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin
ENV NODE_ENV=production
COPY . /app
WORKDIR /app
RUN npm ci --only=production
CMD ["node", "index.js"]