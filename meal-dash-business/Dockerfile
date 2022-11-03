# dev build stage
FROM node:14.14.0-alpine3.12 as initlocaldevelopement
ENV NODE_ENV=development
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# prod build stage
FROM node:14.14.0-alpine3.12 as localdevelopment
ENV NODE_ENV=development
WORKDIR /app
COPY . .
RUN npm install --production --silent 
COPY --from=initlocaldevelopement /app/dist ./dist
EXPOSE 3000
CMD npm run dev
