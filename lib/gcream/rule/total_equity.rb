module Gcream
  module Rule
    class TotalEquity < ConsecutiveGrowth 

      VALUE = 5

      def initialize(balance_sheet, value = VALUE)
        #super balance_sheet, :total_equity, value FIXME
        super balance_sheet, :total_stockholders_equity, value
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
