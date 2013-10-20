module Gcream 
  module Rule
    class Consecutive < Base
      attr_reader :type, :collection

      def initialize(statement, collection, rule_value, frequency, type)
        super statement, rule_value, frequency
        @collection = collection
        @type = type
      end

      def value
        collection.send :"consecutive_#{type}"
      end

      def description
        "#{rule_value} or more #{frequency} of consecutive #{type}"
      end
    end
  end
end
