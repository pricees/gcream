module Gcream

  # Buffetts Rules
  # #1 Vigilant Leadership  (2 rules)
  #   Current Ratio > 1.5
  #   Debt / Equit  < 0.5
  #
  # #2 A stock must have long term prospects (0 Rules)
  #   Hold a stock for less than a year Short-term Gains (Income Tax)
  #   Hold a stock for longer than a year Capital Gains (20%)
  #
  # #3 A stock must be stable and understandable
  #   Stable:
  #   Earnings (EPS) increasing YoY for 5 years  (10 year summary MSN money)
  #   Equity increasing YoY for 5 years
  #   Msn Money -> "Key Ratios" -> 10 year summary for 
  #     BV increasing YoY for 5 years
  #     Debt/Equity decreasing YoY for 5 years
  #
  #   Understandable:
  #   What does the company do?  Sector, etc?
  #
  #
  # 
  #
  #
  # # Teds RULES YO!
  #   Quaterly earnings increasing QoQ
  #
  #
  #
  #
  class BuffettRules

    def initialize(g_skrilla)
      @g_skrilla = g_skrilla
    end

    class BookValuePerShare
      attr_reader :balance_sheet

      def initialize(balance_sheet)
        @balance_sheet = balance_sheet
      end

      def value
        equity = balance_sheet.total_equity.first
        total_shares = balance_sheet.total_common_shares_outstanding.first
        equity.fdiv(total_shares).round(3)
      end

      def description
        "Book Value: Total Equity / Common Shares"
      end

      def report
        [ description, value, "" ]
      end
    end

    # Buffetts Rule #1: Vigiliant Leadership 2/2
    #
    # Watch out for debt, it will kill you
    class CurrentRatio < Rule::Base
      VALUE = 1.5

      def initialize(balance_sheet, value = VALUE, frequency = :Quarter)
        super
      end

      def description
        "Current Assets / Current Liabilities >= #{value}"
      end

      def value
        @value ||= begin
                     ca = statement.total_current_assets.first.to_f
                     cl = statement.total_current_liabilities.first.to_f
                     cl.zero? ? 0 : ca.fdiv(cl).round(2)
                   end
      end
    end

    # Buffetts Rule #1: Vigiliant Leadership 1/2
    #
    # Watch out for debt, it will kill you
    class DebtToEquity < Rule::Base

      VALUE = 0.5

      def initialize(balance_sheet, value = VALUE, frequency = :Quarter)
        super
      end

      def description
        "Debt / Equity <= #{SAFE_VALUE}"
      end

      def value
        @value ||= begin
                     td = statement.total_debt.first.to_f
                     te = statement.total_equity.first.to_f
                     te.zero? ? 0 : td.fdiv(te).round(2)
                   end
      end

      def valid?
        value <= VALUE
      end
    end

    # Straight Forward Grahams Value fo a Stock
    #
    # NOTE: Graham thought no P/E should be over 15
    #       And no price-to-book-ration more than 1.5
    #       1.5 * 15 = 22.5
    #
    #       Working backwords you can find a "fair price"
    #       (P / E) * (P / BV) = 22.5
    #       P * P = 22.5 * E * BV
    #       P = SQRT(22.5 * E * BV)
    class GrahamsNumber < Rule::Base

      attr_reader :summary, :balance_sheet

      def initialize(summary, balance_sheet)
        @summary, @balance_sheet = summary, balance_sheet
      end

      def description 
        "Graham's Number (fair price per share): $"
      end

      def value
        @value ||= begin
                     tmp = PriceToBookValuePerShare.new(summary, balance_sheet)
                     Math.sqrt(22.5 * summary.eps * tmp.value).round(2)
                   end
      end

      def valid?
        value > summary.price
      end
    end


    #  PriceToBookValuePerShare
    #
    #
    class Safety < Rule::Base
      SAFE_VALUE = 20
      attr_reader :summary, :balance_sheet

      def initialize(summary, balance_sheet)
        @summary, @balance_sheet = summary, balance_sheet
      end

      def description
        "Safety (1/P/BV) > #{20}"
      end

      def value
        (1.fdiv(price_to_book_ratio) * 100).round(2)
      end

      def price_to_book_ratio
        PriceToBookValuePerShare.new(summary, balance_sheet).value
      end

      def valid?
        value >= SAFE_VALUE
      end
    end


    class PriceToBookValuePerShare < Rule::Base
      SAFE_VALUE = 1.5
      attr_reader :summary, :balance_sheet

      def initialize(summary, balance_sheet)
        @summary, @balance_sheet = summary, balance_sheet
      end

      def description
        "Price / Book Value should be <= 1.5"
      end

      def value
        summary.price.fdiv(book_value_per_share).round(2)
      end

      def book_value_per_share
        BookValuePerShare.new(balance_sheet).value
      end

      def valid?
        value <= SAFE_VALUE
      end
    end

    class PriceToEarnings < Rule::Base
      SAFE_VALUE = 15
      attr_reader :summary

      def initialize(summary)
        @summary = summary
      end

      def value
        summary.pe
      end

      def description
        "Look for a P/E < 15"
      end

      def valid?
        value <= SAFE_VALUE
      end
    end

    class EPS < Rule::Base
      SAFE_VALUE = 5
      attr_reader :income_statement

      def initialize(income_statement)
        @income_statement = income_statement
      end

      def value
        income_statement.diluted_normalized_eps.consecutive_growth
      end

      def description
        "#{SAFE_VALUE} years (cont.) of increased earnings"
      end

      def valid?
        value >= SAFE_VALUE
      end
    end

    class TedsEPS < Rule::Base
      SAFE_VALUE = 5
      attr_reader :income_statement

      def initialize(income_statement)
        @income_statement = income_statement
      end

      def value
        income_statement.diluted_normalized_eps.consecutive_growth
      end

      def description
        "TEDS RULE: #{SAFE_VALUE} qtrs (cont.) of increased earnings"
      end

      def valid?
        value >= SAFE_VALUE
      end
    end
  end
end

