module Gcream
  module Rule
    class PriceToBookValuePerShare < Rule::Base
      SAFE_VALUE = 1.5
      attr_reader :summary, :balance_sheet

      def initialize(summary, balance_sheet)
        @summary, @balance_sheet = summary, balance_sheet
      end

      def description
        "Price / Book Value should be <= 1.5"
      end

      def value
        summary.price.fdiv(book_value_per_share).round(2)
      end

      def book_value_per_share
        BookValuePerShare.new(balance_sheet).value
      end

      def valid?
        value <= SAFE_VALUE
      end
    end
  end
end
