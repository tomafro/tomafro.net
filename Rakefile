require 'fileutils'

$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))
task :generate do
  require 'lanyon'

  begin
    time "complete site" do
      Lanyon::Site.new('source', 'docker/public').generate
    end
  rescue Object => e
    puts e.message
  end
end

task build: :generate do
  FileUtils.cd File.expand_path("../docker", __FILE__) do
    puts `docker build -t tomafro/tomafro.net .`
    puts `docker push tomafro/tomafro.net`
  end
end

namespace :deploy do
  task :local do
    puts `vagrant ssh docker stop tomafro.net`
  end
end
