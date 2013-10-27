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
      attr_reader :value, :valid_value

      def initialize(price_to_book_value, summary)
        @price_to_book_value = price_to_book_value
        @valid_value = summary.price
        set_value(summary)
      end

      def description 
        "Graham's Number (fair price per share): $"
      end

      def valid?
        value < valid_value
      end

      private

      def set_value(summary = nil)
        @value ||= Math.sqrt(22.5 * summary.eps * price_to_book_value).round(2)
      end
    end
  end
end
