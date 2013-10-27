module Gcream
  module Rule
    class DebtToEquityGrowth < Consecutive

      VALUE = 5

      def initialize(balance_sheet)
        super balance_sheet, book_values, VALUE, :qtr, :growth
        book_balues(balance_sheet)
      end

      def book_values(balance_sheet)
        @book_values ||= begin
                           total_debt_ary = balance_sheet.total_debt
                           total_equity_ary = balance_sheet.total_equity

                           if total_debt_ary.length != total_equity_ary.length
                             raise "# of total_debt value != # total equity values"
                           end

                           total_debt_ary.map.with_index do |debt, i|
                             equity = total_equity_ary[i]
                             if debt && equity 
                               equity.zero? ? 0 : debt.fdiv(equity).round(2)
                             end
                           end.reverse
                         end
      end

      def description
        "YoY Debt-to-equity growth > #{VALUE} years"
      end
    end
  end
end

