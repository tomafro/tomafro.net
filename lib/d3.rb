require 'lanyon'

begin
  time "complete site" do
    Lanyon::Site.new('source', 'public').generate
  end
rescue Object => e
  puts e.message
end