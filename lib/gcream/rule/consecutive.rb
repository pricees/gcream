module Gcream 
  module Rule
    class Consecutive < Base
      attr_reader :type, :attribute

      def initialize(statement, attribute, rule_value, frequency, type)
        super statement, rule_value, frequency
        @attribute = attribute
        @type      = type
      end

      def value
        statement.send(attribute).send :"consecutive_#{type}"
      end

      def description
        "#{rule_value} or more #{frequency} of consecutive #{type}"
      end
    end
  end
end
