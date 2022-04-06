FROM nginx

RUN groupadd --gid 1000 developer && \
    useradd -d /usr/share/nginx/html/ -s /bin/bash -u 1000 -g 1000 -G nginx developer
