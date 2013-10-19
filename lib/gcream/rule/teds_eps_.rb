module Gcream
  module Rule
    class TedsEPS < Base
      SAFE_VALUE = 5
      attr_reader :income_statement

      def initialize(income_statement)
        @income_statement = income_statement
      end

      def value
        income_statement.diluted_normalized_eps.consecutive_growth
      end

      def description
        "TEDS RULE: #{SAFE_VALUE} qtrs (cont.) of increased earnings"
      end

      def valid?
        value >= SAFE_VALUE
      end
    end
  end
end