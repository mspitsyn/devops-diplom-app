FROM nginx:1.27.0
COPY index.html /usr/share/nginx/html/
EXPOSE 80