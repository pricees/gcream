module Gcream
  module Rule
    class ConsecutiveGrowth < Consecutive
      def initialize(statement, attribute, rule_value, frequency = nil)
        super statement, statement.send(attribute), rule_value, frequency, :growth
      end
    end
  end
end
