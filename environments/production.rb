role :app, "webapp01.example.com.vagrant", "webapp02.example.com.vagrant" do
  option :ssh_access_via, "gateway.example.com.vagrant"
  option :ssh_key, "id_rsa.2"
end

role :web, "dmz01.example.com.vagrant", "dmz02.example.com.vagrant"

server "gateway.example.com.vagrant" do
  option :ssh_access_via, "firewall.example.com.vagrant"
end

servers.each do |server|
  server.ssh_user = 'root'
end



