module Gcream 
  module Rule
  end
end
require_relative "rule/base.rb"
require_relative "rule/consecutive.rb"

Dir["#{File.dirname(__FILE__)}/rule/*.rb"].each { |file| require file }
