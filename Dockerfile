ARG NODE_VER=8.15-slim
FROM node:${NODE_VER}

# ----- node build -----
FROM node:${NODE_VER} AS build

# Create app directory and copy everything for build
WORKDIR /prep
COPY . .

RUN npm cache clean --force
RUN npm install

# ----- node release -----
FROM node:${NODE_VER} AS release

# Only copy release files from build
WORKDIR /usr/src/app
COPY --from=build /prep/node_modules ./node_modules
COPY --from=build /prep/package.json ./package.json
COPY --from=build /prep/index.js ./index.js

EXPOSE 3000
CMD ["node", "index.js"]
