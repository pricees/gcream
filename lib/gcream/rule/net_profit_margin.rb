module Gcream
  module Rule
    class NetProfitMargin < Base

      attr_reader :income_statement, :valid_value

      VALUE = 0

      def initialize(income_statement, valid_value = VALUE)
        @income_statement = income_statement
        @valid_value = valid_value
      end

      def value
        @value ||= income_statement.net_income.fdiv(income_statement.revenue)
      end

      def valid?
        value > valid_value
      end

      def description
        "A ratio of profitability calculated as net income divided by revenues, or net profits divided by sales. It measures how much out of every dollar of sales a company actually keeps in earnings."
      end
    end
  end
end
