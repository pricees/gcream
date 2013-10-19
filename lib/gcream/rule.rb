module Gcream 
  module Rule
  end
end

# Load these in order
require_relative "rule/base.rb"
require_relative "rule/consecutive.rb"

# Load the rest
Dir["#{File.dirname(__FILE__)}/rule/*.rb"].each { |file| require file }
