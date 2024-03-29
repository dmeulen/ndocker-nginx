FROM alpine:3.9

MAINTAINER Danny van der Meulen <danny@cb750k6.nl>

ENV \
  ALPINE_MIRROR="dl-4.alpinelinux.org" \
  ALPINE_VERSION="v3.9" \
  CONSUL_TEMPLATE_VERSION=0.19.4 \
  APK_ADD_TEMP="curl" \
  APK_ADD_PERM="ca-certificates nginx"

EXPOSE 80

WORKDIR /

RUN \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/main" > /etc/apk/repositories && \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
  apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add ${APK_ADD_TEMP} ${APK_ADD_PERM} && \
  curl -L https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o /tmp/consul-template.zip && \
  unzip /tmp/consul-template.zip -d /usr/bin && \
  apk --purge del ${APK_ADD_TEMP} && \
  rm -rf \
    /tmp/* \
    /var/cache/apk/*

COPY rootfs/ /

CMD ["/init/run.sh"]
