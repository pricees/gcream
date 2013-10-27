#
#
module Gcream
  module Rule
    class EPS < ConsecutiveGrowth 

      VALUE = 5

      def initialize(income_statement, value = VALUE)
        super income_statement, :diluted, value
      end

      def description
        "Consecutive growth using the diluted normalized eps"
      end

      def valid?
        value >= VALUE
      end
    end
  end
end
