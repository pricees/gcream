module Gcream
  module Rule
    class BookValuePerShare < Base

      attr_reader :value
      def initialize(balance_sheet)
        set_value(balance_sheet)
      end

      def description
        "Book Value: Total Equity / Common Shares"
      end

      def report
        [ description, value, "" ]
      end

      private

      def set_value(balance_sheet)
        @value ||= begin
                     equity = balance_sheet.total_equity.first
                     total_shares = balance_sheet.
                       total_common_shares_outstanding.
                       first
                     equity.fdiv(total_shares).round(3)
                   end
      end

    end
  end
end
