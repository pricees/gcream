module Gcream

  class BuffettRules

    class Rule
      def report
       [ description, value, valid? ]
      end
    end

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

    #
    #
    #
    #
    class CurrentRatio < Rule
      SAFE_VALUE = 1.5
      attr_reader :bs

      def initialize(balance_sheet)
        @bs = balance_sheet
      end

      def description
        "Current Assets / Current Liabilities <= #{SAFE_VALUE}"
      end

      def value
        @value ||= begin
                     ca = bs.total_current_assets.first.to_f
                     cl = bs.total_current_liabilities.first.to_f
                     cl.zero? ? 0 : ca.fdiv(cl).round(2)
                   end
      end

      def valid?
        value >= SAFE_VALUE
      end
    end

    #
    #
    #
    #
    class DebtToEquity < Rule
      SAFE_VALUE = 0.5
      attr_reader :bs

      def initialize(balance_sheet)
        @bs = balance_sheet
      end

      def description
        "Debt / Equity <= 0.5"
      end

      def value
        @value ||= begin
                     td = bs.total_debt.first.to_f
                     te = bs.total_equity.first.to_f
                     te.zero? ? 0 : td.fdiv(te).round(2)
                   end
      end

      def valid?
        value <= SAFE_VALUE
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
    class GrahamsNumber < Rule

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
        @value > summary.price
      end
    end

    class PriceToBookValuePerShare
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

      def report
        [description, value, valid?]
      end
    end

    class PriceToEarnings < Rule
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
  end
end

