module Gcream
  module Rule
    class PriceToBookValuePerShare < Base
      VALUE = 1.5
      attr_reader :value

      def initialize(summary, balance_sheet, valid_value = VALUE)
        set_value(summary, balance_sheet)
      end

      def description
        "Price / Book Value should be <= #{valid_value}"
      end

      def valid_value
        @valid_value ||= VALUE
      end

      def set_value(summary, balance_sheet)
        @value ||= begin
                     bv_per_share = BookValuePerShare.
                       new(balance_sheet, summary).value
                     summary.price.fdiv(bv_per_share).round(2)
                   end
      end

      def valid?
        value <= valid_value
      end
    end
  end
end
