# dev build stage
FROM node:14.14.0-alpine3.12 as development
ENV NODE_ENV=development
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# prod build stage
FROM node:14.14.0-alpine3.12 as production
ENV NODE_ENV=development
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "docs", "./"]
COPY ["docs", "./docs"]
RUN npm install --production --silent 
COPY --from=development /usr/src/app/dist ./dist
EXPOSE 3000
# CMD npm run dev
CMD ["node", "dist/server.js"]
