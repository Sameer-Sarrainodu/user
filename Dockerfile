# optimized method
# ==========================
# Stage 1: Build dependencies
# ==========================
FROM node:20-alpine3.21 AS builder

WORKDIR /opt/server

# Copy dependency file and install ONLY production deps
COPY package.json .
RUN npm install --omit=dev

# Copy application JS files
COPY *.js .


# ==========================
# Stage 2: Runtime Image
# ==========================
FROM node:20-alpine3.21

# Create non-root system user
RUN addgroup -S roboshop && \
    adduser -S -G roboshop roboshop

WORKDIR /opt/server
USER roboshop

# Environment variables
ENV MONGO=true \
    MONGO_URL=mongodb://mongodb:27017/users \
    REDIS_URL=redis://redis:6379

# Copy built app from builder
COPY --from=builder --chown=roboshop:roboshop /opt/server /opt/server

EXPOSE 8080

CMD ["node", "server.js"]






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

