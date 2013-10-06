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

    class Rule
      attr_reader :statement, :frequency

      def initialize(statement, frequency = :Quarters)
        @statement = statement
        @frequency = frequency
      end

      def report
       [ description, value, valid? ]
      end
    end

    # Operating activities are the machinery of the business, this should
    # be increasing
    class CashFromOperatingActivities < Rule
      VALUE = 4

      def value
        statement.cash_from_operating_activities.consecutive_growth
      end

      def description
        "#{frequency} of continuous operating activities growth > #{VALUE} #{frequency}"
      end

      def valid?
        value >= VALUE
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
    class CashFromInvestingActivities < Rule
      VALUE = 4

      def value
        statement.cash_from_investing_activities.consecutive_decline
      end

      def description
        "#{frequency} of continuous investing activities growth > #{VALUE} #{frequency}"
      end

      def valid?
        value >= VALUE
      end
    end

    # Financing activies include paying off debt, selling stock etc.
    #
    # If its negative, it probably paid off debt
    # If its positive, it probably sold debt, or stock. 
    #
    # Look for a negative trend
    class CashFromFinancingActivities < Rule
      VALUE = 4

      def value
        statement.cash_from_financing_activities.consecutive_decline
      end

      def description
        "#{frequency} of continuous financing activities decline > #{VALUE} #{frequency}"
      end

      def valid?
        value >= VALUE
      end
    end
  end
end
