# syntax=docker/dockerfile:1

FROM node:16.14.2-alpine as base

# ENV NODE_ENV=production

WORKDIR /.

COPY ["package.json", "package-lock.json", "./"]

FROM base as test
RUN npm ci
COPY . .
RUN npm run test

FROM base as prod
RUN npm ci --production
COPY . .
CMD ["node", "index.js"]

