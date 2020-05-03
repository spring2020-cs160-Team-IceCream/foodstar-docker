FROM smebberson/alpine-nginx:3.0.0

# Install nvm with node and npm
RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/main libuv \
    && apk add --no-cache --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main nodejs nodejs-npm \
    && apk add --no-cache --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community yarn \
    && echo "NodeJS Version:" "$(node -v)" \
    && echo "NPM Version:" "$(npm -v)" \
    && echo "Yarn Version:" "$(yarn -v)"


ENV NODE_ENV=docker

COPY backend /app/

COPY frontend /var/www/html/frontend/

COPY files /var/www/html/files/

COPY index.html /var/www/html/

COPY default.conf /etc/nginx/conf.d/

RUN chown -R nginx:www-data /var/www/html

WORKDIR /app/

RUN yarn install

CMD ["node", "/app/backend.js"]