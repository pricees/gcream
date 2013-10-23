module Gcream
  module Rule
    class FloatShares < Base
      attr_reader :rule_value

      def initialize(float_shares, rule_value = 20_000_000)
        @value, @rule_value = float_shares, rule_value
      end

      def value
        @value
      end

      def description
        "Are float shares (#{value}) <= #{rule_value})"
      end

      def report
        [ description, value, valid? ]
      end
    end
  end
end
