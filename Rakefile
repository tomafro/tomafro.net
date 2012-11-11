$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))
task :generate do
  require 'lanyon'

  begin
    time "complete site" do
      Lanyon::Site.new('source', 'public').generate
    end
  rescue Object => e
    puts e.message
  end
end
# http://rubycorner.com/ping/xmlrpc/aaf9d1cc0ecf5723fd2610063cfa60d82528cd6d