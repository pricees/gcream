module Gcream
  module Rule
    # Buffetts Rule #1: Vigiliant Leadership 1/2
    #
    # Watch out for debt, it will kill you
    class DebtToEquity < Base

      VALUE = 0.5

      attr_reader :value
      def initialize(balance_sheet, value = VALUE, frequency = :Quarter)
        super
        set_value(balance_sheet)
      end

      def description
        "Debt / Equity <= #{VALUE}"
      end

      def valid?
        value <= VALUE
      end

      private

      def set_value(balance_sheet)
        @value ||= begin
                     td = balance_sheet.total_debt.first.to_f
                     te = balance_sheet.total_equity.first.to_f
                     te.zero? ? 0 : td.fdiv(te).round(2)
                   end
      end
    end
  end
end
