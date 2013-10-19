module Gcream
  module Rule
    # Buffetts Rule #1: Vigiliant Leadership 1/2
    #
    # Watch out for debt, it will kill you
    class DebtToEquity < Base

      VALUE = 0.5

      def initialize(balance_sheet, value = VALUE, frequency = :Quarter)
        super
      end

      def description
        "Debt / Equity <= #{SAFE_VALUE}"
      end

      def value
        @value ||= begin
                     td = statement.total_debt.first.to_f
                     te = statement.total_equity.first.to_f
                     te.zero? ? 0 : td.fdiv(te).round(2)
                   end
      end

      def valid?
        value <= VALUE
      end
    end
  end
end
