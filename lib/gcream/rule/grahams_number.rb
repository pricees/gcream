module Gcream
  module Rule
    # Straight Forward Grahams Value fo a Stock
    #
    # NOTE: Graham thought no P/E should be over 15
    #       And no price-to-book-ration more than 1.5
    #       1.5 * 15 = 22.5
    #
    #       Working backwords you can find a "fair price"
    #       (P / E) * (P / BV) = 22.5
    #       P * P = 22.5 * E * BV
    #       P = SQRT(22.5 * E * BV)
    class GrahamsNumber < Base
      attr_reader :summary, :price_to_book_value

      def initialize(price_to_book_value, summary)
        @price_to_book_value = price_to_book_value
        @summary = summary
      end

      def description 
        "Graham's Number (fair price per share): $"
      end

      def value
        @value ||= Math.sqrt(22.5 * summary.eps * price_to_book_value).round(2)
      end

      def valid?
        value < summary.price
      end
    end
  end
end
