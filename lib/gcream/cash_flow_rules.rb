module Gcream
  module CashFlowRules

    def self.print_nice(ary, size = 20)
    end

    def self.new(cash_flow)
      [
        CashFromOperatingActivities.new(cash_flow.qtr, "Quarters").report,
        CashFromInvestingActivities.new(cash_flow.qtr, "Quarters").report,
        CashFromFinancingActivities.new(cash_flow.qtr, "Quarters").report,
        CashFromOperatingActivities.new(cash_flow.yr, "Years").report,
        CashFromInvestingActivities.new(cash_flow.yr, "Years").report,
        CashFromFinancingActivities.new(cash_flow.yr, "Years").report,
      ]
    end

    # Operating activities are the machinery of the business, this should
    # be increasing
    class CashFromOperatingActivities < Rule::ConsecutiveGrowthRule
      VALUE = 4

      def initialize(statement, value = VALUE, frequency = :Quarters)
        super statement, :cash_from_operating_activities, value, frequency
      end

      def description
        "Operating Activities: #{super}"
      end
    end
    
    # Investing Activities including buying raw materials, expanding factories,
    # or investing in other companyies.
    #
    # Negative cash means that the company invested in something.  This is
    # "good"
    #
    # Positive cash means that the company sold something.  We should
    # investigate this
    class CashFromInvestingActivities < Rule::ConsecutiveDeclineRule
      VALUE = 4

      def initialize(statement, value = VALUE, frequency = :Quarters)
        super statement, :cash_from_investing_activities, value, frequency
      end

      def description
        "Investing Activities: #{super}"
      end
    end

    # Financing activies include paying off debt, selling stock etc.
    #
    # If its negative, it probably paid off debt
    # If its positive, it probably sold debt, or stock. 
    #
    # Look for a negative trend
    class CashFromFinancingActivities < Rule::ConsecutiveDeclineRule

      VALUE = 4

      def initialize(statement, value = VALUE, frequency = :Quarters)
        super statement, :cash_from_financing_activities, value, frequency
      end

      def description
        "Financing Activities: #{super}"
      end
    end
  end
end
