from alpine:3.8

run sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

run apk add --no-cache gcc libc-dev make curl curl-dev unzip 

run mkdir -p /dnsforwarder

workdir /dnsforwarder

run curl -L -o dnsforwarder.zip https://github.com/holmium/dnsforwarder/archive/6.zip

run unzip dnsforwarder.zip && mv ./dnsforwarder-6/* .

run ./configure && make && make install 

copy config /etc/dnsforwarder/config

workdir /

run rm -rf /dnsforwarder

expose 53
expose 53/udp

cmd ["dnsforwarder","-q","-f","/etc/dnsforwarder/config"]
