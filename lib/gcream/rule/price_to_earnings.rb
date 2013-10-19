module Gcream
  module Rule
    class PriceToEarnings < Base
      SAFE_VALUE = 15
      attr_reader :summary

      def initialize(summary)
        @summary = summary
      end

      def value
        summary.pe
      end

      def description
        "Look for a P/E < 15"
      end

      def valid?
        value <= SAFE_VALUE
      end
    end
  end
end
