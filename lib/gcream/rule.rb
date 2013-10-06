module Gcream 
  class Rule
    attr_reader :statement, :frequency, :rule_value

    # Public: "Abstract" class for rules
    #
    # statement  - The financial statement to run the rule against
    # rule_value - Value to run the validation against
    # frequency  - Frequency of statement: quarterly, yearly
    #
    # Returns an instance of a rule
    def initialize(statement, rule_value, frequency)
      @statement  = statement
      @frequency  = frequency
      @rule_value = rule_value
    end

    def report
      [ description, value, valid? ]
    end

    def rule
      raise "Create #rule"
    end

    def pass?
      raise "Create #pass?"
    end

    def valid?
      raise "Create #valid?"
    end

    def description
      raise "Create #description" 
    end
  end
end
