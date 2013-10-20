module Gcream
  module Rule
    class ConsecutiveDecline < Consecutive
      def initialize(statement, attribute, rule_value, frequency)
        super statement, statement.send(attribute), rule_value, frequency, :decline
      end
    end
  end
end
