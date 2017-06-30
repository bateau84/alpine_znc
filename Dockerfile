FROM bateau/alpine_baseimage:latest

ADD . /bd_build/

RUN /bd_build/prepare.sh && \
    /bd_build/system_services.sh && \
    /bd_build/cleanup.sh

EXPOSE 30200/tcp
