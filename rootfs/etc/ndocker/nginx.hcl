max_stale = "1m"

consul {
  address = "consul.service.consul:8500"
}
exec {
  command = "/usr/sbin/nginx"
  reload_signal = "SIGHUP"
  splay = "10s"
}
template {
  source = "/templates/nginx.conf.tpl"
  destination = "/etc/nginx/nginx.conf"
}
