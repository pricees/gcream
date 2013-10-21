module Gcream
  module Rule
    class BookValuePerShareGrowth < Consecutive
      attr_reader :balance_sheet

      VALUE = 5

      def initialize(balance_sheet)
        super balance_sheet, book_values, VALUE, :qtr, :growth
      end

      def book_values
        equity_ary = balance_sheet.total_equity
        total_shares_ary = balance_sheet.total_common_shares_outstanding

        if equity_ary.length != total_shares_ary.length
          raise "# of equity value != # total share values"
        end

        equity_ary.map.with_index do |equity, i|
          equity.fdiv(total_shares_ary[i]).round(3)
        end.reverse
      end

      def description
        "YoY book value growth > #{VALUE} years"
      end
    end
  end
end
