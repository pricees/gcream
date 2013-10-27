# Takes an array of values and looks for consecutive terms of accelerated growth
#
# Lets say you have earnings:
#
# 15, 10, 8, 4, 1
#
# You would have "accelerated growth" as a percentage of growth between the
# earnings:
# [0.5, 25, 2, 4 ]
#
module Gcream
  module Rule
    class ConsecutiveAcceleratedGrowth

      attr_reader :earnings, :valid_value

      def initialize(income_statement, valid_value = 0)
        @earnings = income_statement.diluted_normalized_eps
        @valid_value = valid_value
      end

      def growth_percentages
        (0...earnings.size - 1).map do |i|
          e1 = earnings[i] 
          e2 = earnings[i + 1] 
          (e1-e2).fdiv(e2) if e1 && e2 
        end
      end

      def value
        rule.value
      end

      def valid?
        value >= valid_value
      end

      def rule
        @rule ||= Consecutive.new(nil, growth_percentages, 4, :qtr, :growth)
      end
    end
  end
end
