module Gcream
  module Rule
    class MarginOfSafety < Base
      VALUE = 20
      attr_reader :price_to_book_ratio 

      def initialize(price_to_book_ratio)
        @price_to_book_ratio = price_to_book_ratio
      end

      def description
        "Safety (1/P/BV) > #{VALUE}"
      end

      def value
        (1.fdiv(price_to_book_ratio) * 100).round(2)
      end

      def valid?
        value >= VALUE
      end
    end
  end
end
