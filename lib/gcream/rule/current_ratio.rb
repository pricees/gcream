# Buffetts Rule #1: Vigiliant Leadership 2/2
#
# Watch out for debt, it will kill you
module Gcream
  module Rule
    class CurrentRatio < Base
      VALUE = 1.5

      def initialize(balance_sheet, value = VALUE, frequency = :Quarter)
        super
      end

      def description
        "Current Assets / Current Liabilities >= #{value}"
      end

      def value
        @value ||= begin
                     ca = statement.total_current_assets.first.to_f
                     cl = statement.total_current_liabilities.first.to_f
                     cl.zero? ? 0 : ca.fdiv(cl).round(2)
                   end
      end
    end
  end
end
