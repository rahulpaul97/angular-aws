FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci


COPY . .
RUN npm run build


FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf


COPY nginx.conf /etc/nginx/conf.d/app.conf


COPY --from=builder /app/dist/second-project/browser /usr/share/nginx/html


RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && mkdir -p /var/cache/nginx /var/run/nginx \
    && chown -R appuser:appgroup \
        /usr/share/nginx/html \
        /var/cache/nginx \
        /var/run/nginx

USER appuser

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]