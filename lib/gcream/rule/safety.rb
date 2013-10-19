module Gcream
  module Rule
    #  PriceToBookValuePerShare
    #
    #
    class Safety < Base
      SAFE_VALUE = 20
      attr_reader :summary, :balance_sheet

      def initialize(summary, balance_sheet)
        @summary, @balance_sheet = summary, balance_sheet
      end

      def description
        "Safety (1/P/BV) > #{20}"
      end

      def value
        (1.fdiv(price_to_book_ratio) * 100).round(2)
      end

      def price_to_book_ratio
        PriceToBookValuePerShare.new(summary, balance_sheet).value
      end

      def valid?
        value >= SAFE_VALUE
      end
    end
  end
end
