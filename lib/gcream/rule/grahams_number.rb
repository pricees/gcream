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

      attr_reader :summary, :balance_sheet

      def initialize(summary, balance_sheet)
        @summary, @balance_sheet = summary, balance_sheet
      end

      def description 
        "Graham's Number (fair price per share): $"
      end

      def value
        @value ||= begin
                     tmp = PriceToBookValuePerShare.new(summary, balance_sheet)
                     Math.sqrt(22.5 * summary.eps * tmp.value).round(2)
                   end
      end

      def valid?
        value > summary.price
      end
    end
  end
end
