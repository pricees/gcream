module Gcream
  module Rule
    class FloatShares < Base
      attr_reader :rule_value

      # NOTE: Shares are in millions, so we are looking at 20MM shares
      def initialize(float_shares, rule_value = 20)
        @value, @rule_value = float_shares.to_f, rule_value.to_f
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
