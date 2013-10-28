module Gcream
  module Rule
    class PriceToEarnings < Base
      attr_reader :summary, :value

      def initialize(summary, eps)
        @value = summary.ask_price.fdiv(eps)
      end

      def rule_value
        15
      end

      def description
        "Look for a P/E < #{rule_value}"
      end

      def valid?
        value <= rule_value
      end
    end
  end
end
