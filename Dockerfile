FROM nginx:1.18
COPY *.html /usr/share/nginx/html
COPY style.css /usr/share/nginx/html

