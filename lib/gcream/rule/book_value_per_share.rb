module Gcream
  module Rule
    class BookValuePerShare < Base

      attr_reader :value
      def initialize(balance_sheet, summary)
        set_value(balance_sheet, summary)
      end

      def description
        "Book Value: Total Equity / Common Shares"
      end

      def report
        [ description, value, "" ]
      end

      private

      def set_value(balance_sheet, summary)
        @value ||= begin
                     equity       = balance_sheet.total_equity.first
                     total_shares = summary.float_shares
                     equity.fdiv(total_shares).round(3)
                   end
      end

    end
  end
end
