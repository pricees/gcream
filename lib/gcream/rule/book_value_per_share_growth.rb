module Gcream
  module Rule
    class BookValuePerShareGrowth < Consecutive
      VALUE = 5

      attr_reader :book_values

      def initialize(balance_sheet, key_ratios)
        set_book_values(balance_sheet, key_ratios)
        super balance_sheet, book_values, VALUE, :qtr, :growth
      end

      def set_book_values(balance_sheet, key_ratios)
        @book_values ||= begin
                           equity_ary       = balance_sheet.total_equity
                           total_shares_ary = key_ratios.shares

                           equity_ary.map.with_index do |equity, i|
                             if equity && total_shares_ary[i]
                               equity.fdiv(total_shares_ary[i]).round(3) 
                             end
                           end.compact.reverse
                         end
      end

      def description
        "YoY book value growth > #{VALUE} years"
      end
    end
  end
end
