module Gcream
  module Rule
    class EPS < Base

      VALUE = 5
      attr_reader :income_statement

      def initialize(income_statement)
        @income_statement = income_statement
      end

      def value
        income_statement.diluted_normalized_eps.consecutive_growth
      end

      def description
        "#{VALUE} years (cont.) of increased earnings"
      end

      def valid?
        value >= VALUE
      end
    end
  end
end
