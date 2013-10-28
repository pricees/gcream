# Buffetts Rule #1: Vigiliant Leadership 2/2
#
# Watch out for debt, it will kill you
module Gcream
  module Rule
    class CurrentRatio < Base
      VALUE = 1.5

      attr_reader :value
      def initialize(balance_sheet, value = VALUE, frequency = :Quarter)
        super
        set_value(balance_sheet)
      end

      def description
        "Current Assets / Current Liabilities >= #{rule_value}"
      end

      private

      def set_value(balance_sheet)
        @value ||= begin
                     ca = balance_sheet.total_current_assets.first.to_f
                     cl = balance_sheet.total_current_liabilities.first.to_f
                     cl.zero? ? 0 : ca.fdiv(cl).round(2)
                   end
      end
    end
  end
end
