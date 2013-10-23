module Gcream
  module Rule
    class PctOf52WeekHigh < Base
      attr_reader :rule_value

      def initialize(percent_change, rule_value = 15)
        @value, @rule_value = percent_change.abs, rule_value
      end

      def value
        @value
      end

      def valid?
        value <= rule_value
      end

      def description
        "Is % change of price from 52-week high (#{value}) <= #{rule_value})"
      end

      def report
        [ description, value, valid? ]
      end
    end
  end
end
