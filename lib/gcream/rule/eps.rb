module Gcream
  module Rule
    class EPS < ConsecutiveGrowth 

      VALUE = 5
      attr_reader :income_statement

      def initialize(statement, value = VALUE)
        super statement, :diluted_normalized_eps, value
      end

      def description
        "EPS: #{super}"
      end

      def valid?
        value >= VALUE
      end
    end
  end
end
