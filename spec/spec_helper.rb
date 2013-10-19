require_relative "../lib/gcream.rb"

RSpec.configure do |c|
  # declare an exclusion filter
  c.filter_run_excluding :broken => true
end
