# optimized method
FROM node:20-alpine3.21 AS builder
WORKDIR /opt/server
COPY package.json .
COPY *.js .
RUN npm install

FROM node:20-alpine3.21
RUN addgroup -S roboshop && \
    adduser -S -D -H -h /opt/server -s /sbin/nologin -G roboshop roboshop
ENV MONGO_URL=mongodb://mongodb:27017/users \
    REDIS_URL=redis://redis:6379 \
    MONGO=true
WORKDIR /opt/server
USER roboshop
COPY --from=builder /opt/server /opt/server
CMD ["node","server.js"]





# first base method
# FROM node:20
# RUN groupadd -r roboshop && \
#     useradd -r -g roboshop -d /opt/server -s /usr/sbin/nologin roboshop
# WORKDIR /opt/server
# COPY package.json . 
# COPY server.js .
# RUN npm install
# ENV MONGO="true" \
#     REDIS_URL="redis://redis:6379" \
#     MONGO_URL="mongodb://mongodb:27017/users"
# USER roboshop
# CMD [ "node", "server.js" ]

