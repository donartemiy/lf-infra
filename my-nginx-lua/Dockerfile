# Устаночка из исходников nginx 1.26.2 + lua
FROM debian
WORKDIR /opt
RUN apt update && \
    apt install -y curl make libxml2-utils xsltproc patch lsb-release devscripts libssl-dev zlib1g-dev libpcre2-dev quilt && \
    curl -O https://hg.nginx.org/pkg-oss/archive/4e0f19ed237a.tar.gz && \
    tar -xvf 4e0f19ed237a.tar.gz && \
    make -j$(nproc) -C /opt/pkg-oss-4e0f19ed237a/debian/ base && \
    make -j$(nproc) -C /opt/pkg-oss-4e0f19ed237a/debian/ module-ndk && \
    make -j$(nproc) -C /opt/pkg-oss-4e0f19ed237a/debian/ module-lua && \
    dpkg -i /opt/nginx_1.26.2-1~bookworm_amd64.deb && \
    dpkg -i /opt/nginx-module-ndk_1.26.2+0.3.3-1~bookworm_amd64.deb && \
    dpkg -i /opt/nginx-module-lua_1.26.2+0.10.26-1~bookworm_amd64.deb && \
    nginx -t && \
    rm -rf /var/lib/apt/lists/*


EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]
# https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/

# docker build --tag my-nginx-lua .
# docker run -d -v ./nginx.conf:/etc/nginx/nginx.conf -p 80:80 my-nginx-lua