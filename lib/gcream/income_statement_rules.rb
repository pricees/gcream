module Gcream
  module IncomeStatementRules

    class EPS < Rule::ConsecutiveGrowth
      VALUE = 5

      def initialize(statement, value = VALUE)
        super statement, :diluted_normalized_eps, value
      end

      def description
        "EPS: #{super}"
      end
    end
  end
end
