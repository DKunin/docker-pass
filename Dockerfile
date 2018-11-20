FROM docker:latest
LABEL maintainer="Dmitri Kunin <info@dkunin.ru>"

RUN apk add --no-cache bash \
	&& apk add --no-cache --update duplicity \
	&& apk add --no-cache --update tree \
	&& apk add --no-cache --update git \
    && apk add --no-cache --virtual .deps curl make \
    && curl -sSO https://git.zx2c4.com/password-store/snapshot/password-store-master.tar.xz \
    && tar -xf password-store-master.tar.xz \
    && cd password-store-master \
    && make install \
    && cd .. \
    && rm password-store-master.tar.xz \
    && rm -rf password-store-master \
    && apk del .deps

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["sh"]