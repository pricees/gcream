module Gcream
  module Rule
    class DebtToEquityGrowth < Consecutive
      attr_reader :balance_sheet

      VALUE = 5

      def initialize(balance_sheet)
        super balance_sheet, book_values, VALUE, :qtr, :growth
      end

      def book_values
        total_debt_ary = statement.total_debt
        total_equity_ary = statement.total_equity

        if total_debt_ary.length != total_equity_ary.length
          raise "# of total_debt value != # total equity values"
        end

        total_debt_ary.map.with_index do |debt, i|
          equity = total_equity_ary[i]
          equity.zero? ? 0 : debt.fdiv(equity).round(2)
        end.reverse
      end

      def description
        "YoY Debt-to-equity growth > #{VALUE} years"
      end
    end
  end
end

