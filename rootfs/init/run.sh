#!/bin/sh

set -x

mkdir /run/nginx
chown nginx:nginx /run/nginx

consul-template -config /etc/ndocker/nginx.hcl
nginx_pid=$!

trap "kill $nginx_pid" INT TERM
wait $nginx_pid
