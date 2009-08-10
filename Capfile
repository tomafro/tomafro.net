role :web, "tomafro.net"
set :site, "tomafro.net"
set :site_path, "/var/sites"
set :config_path, "/etc/apache2"


task 'publish' do
  `tar czf #{site}.tar.gz build`
  
  run "mkdir -p publish"
  run "rm -r publish/#{site}"
  run "mkdir -p publish/#{site}"
  
  upload "#{site}.tar.gz", "publish/#{site}/#{site}.tar.gz"
  
  run "gunzip ~/publish/#{site}/#{site}.tar.gz"
  run "cd ~/publish/#{site}; tar xvf ~/publish/#{site}/#{site}.tar"
  run "rm -r #{site_path}/#{site}" rescue nil
  run "mv ~/publish/#{site}/build #{site_path}/#{site}"
end
