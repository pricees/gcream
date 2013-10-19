module Gcream 
  module Rule
  end
end

Dir["#{File.dirname(__FILE__)}/rule/*.rb"].each { |file| require file }
