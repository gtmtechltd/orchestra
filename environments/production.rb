role :app, "usrwap01.nowtv.bskyb.vagrant", "usrwap02.nowtv.bskyb.vagrant" do
  option :ssh_access_via => "gateway.nowtv.bskyb.vagrant"
  option :ssh_key => "id_rsa.2"
end

role :web, "dmz01.nowtv.bskyb.vagrant", "dmz02.nowtv.bskyb.vagrant"

server "gateway.nowtv.bskyb.vagrant" do
  option :ssh_access_via => "firewall.nowtv.bskyb.vagrant"
end

servers.each do |server|
  server.ssh_user = 'root'
end

production.YAML >>

roles:
  app:
    servers:
      usrwap01.nowtv.bskyb.vagrant
      usrwap02.nowtv.bskyb.vagrant
    options:
      ssh_access_via: gateway.nowtv.bskyb.vagrant
      ssh_key: id_rsa.2
  web:
    servers:
      dms01.nowtv.bskyb.vagrant

servers:
  DEFAULT:
    ssh_access_via:
  gateway.nowt.vagrant:
    ssh_access_via:

