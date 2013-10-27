module Gcream 
  module Rule
    class Base
      attr_reader :statement, :frequency
      attr_accessor :rule_value

      # Public: "Abstract" class for rules
      #
      # statement  - The financial statement to run the rule against
      # rule_value - Value to run the validation against
      # frequency  - Frequency of statement: quarterly, yearly
      #
      # Returns an instance of a rule
      def initialize(statement, rule_value, frequency)
#        value(statement) FIXME
        @frequency  = frequency
        @rule_value = rule_value
      end

      def report
        [ description, value, valid? ]
      end

      def value(*args)
        raise "implement #value"
      end

      def valid?
        value >= rule_value
      end

      def pass?
        raise "Create #pass?"
      end

      def description
        raise "Create #description" 
      end
    end

  end
end
