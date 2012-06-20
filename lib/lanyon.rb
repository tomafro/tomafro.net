require 'lanyon/version'
require 'lanyon/template'
require 'lanyon/site'
require 'active_support/all'

$indent = 0

def time(description, &block)
  puts (" " * $indent) + "#{description}"
  $indent = $indent + 2
  time = Time.now
  result = yield
  $indent = $indent - 2
  puts (" " * $indent) + "#{Time.now - time}"
  result
end

module Lanyon
  # Your code goes here...
end
