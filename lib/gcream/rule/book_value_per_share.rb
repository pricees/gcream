module Gcream
  module Rule
    class BookValuePerShare
      attr_reader :balance_sheet

      def initialize(balance_sheet)
        @balance_sheet = balance_sheet
      end

      def value
        equity = balance_sheet.total_equity.first
        total_shares = balance_sheet.total_common_shares_outstanding.first
        equity.fdiv(total_shares).round(3)
      end

      def description
        "Book Value: Total Equity / Common Shares"
      end

      def report
        [ description, value, "" ]
      end
    end
  end
end
