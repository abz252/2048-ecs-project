FROM nginxinc/nginx-unprivileged:mainline-alpine3.24-perl

COPY . /usr/share/nginx/html

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --start-interval=5s --retries=3 \
CMD curl -f http://localhost:8080/ || exit 1

CMD ["nginx", "-g", "daemon off;"]



