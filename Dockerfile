FROM node:lts as builder

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

FROM node:lts-slim

ENV NODE_ENV production
USER node

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY --from=builder /app/dist ./dist

ARG KEY_NAME
ENV KEY_NAME ${KEY_NAME}

EXPOSE 3000
CMD [ "yarn", "start:prod" ]
