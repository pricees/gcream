module Gcream 
  class Rule
    attr_reader :statement, :frequency
    attr_accessor :rule_value

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

    def value
      raise "implement #value"
    end

    def valid?
      value >= rule_value
    end

    def pass?
      raise "Create #pass?"
    end

    def description
      raise "Create #description" 
    end
  end

  class ConsecutiveRule < Rule

    attr_reader :type, :attribute

    def initialize(statement, attribute, rule_value, frequency, type)
      super statement, rule_value, frequency
      @attribute = attribute
      @type      = type
    end

    def value
      statement.send(attribute).send :"consecutive_#{type}"
    end

    def description
      "#{rule_value} or more #{frequency} of consecutive #{type}"
    end
  end

  class ConsecutiveGrowthRule < ConsecutiveRule
    def initialize(statement, attribute, rule_value, frequency = nil)
      super statement, attribute, rule_value, frequency, :growth
    end
  end

  class ConsecutiveDeclineRule < ConsecutiveRule
    def initialize(statement, attribute, rule_value, frequency)
      super statement, attribute, rule_value, frequency, :decline
    end
  end
end
