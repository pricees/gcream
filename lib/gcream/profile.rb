module Gcream 
  module Profile
  end
end

# Load the rest
Dir["#{File.dirname(__FILE__)}/profile/*.rb"].each { |file| require file }
