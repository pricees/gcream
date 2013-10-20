module Gcream
  module Rule
    class PriceToBookValuePerShare < Base
      VALUE = 1.5
      attr_reader :summary, :balance_sheet

      def initialize(summary, balance_sheet, valid_value = VALUE)
        @summary, @balance_sheet = summary, balance_sheet
      end

      def description
        "Price / Book Value should be <= #{valid_value}"
      end

      def valid_value
        @valid_value ||= VALUE
      end

      def value
        summary.price.fdiv(book_value_per_share).round(2)
      end

      def book_value_per_share
        BookValuePerShare.new(balance_sheet).value
      end

      def valid?
        value <= valid_value
      end
    end
  end
end
