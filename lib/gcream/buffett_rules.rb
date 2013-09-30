module Gcream

  class BuffettRules

    def initialize(g_skrilla)
      @g_skrilla = g_skrilla
    end

    class CurrentRatio
      SAFE_VALUE = 1.5
      attr_reader :bs

      def initialize(balance_sheet)
        @bs = balance_sheet
      end

      def value
        @value ||=
          begin
            ca = bs.total_current_assets.first.to_f
            cl = bs.total_current_liabilities.first.to_f
            cl.zero? ? 0 : ca.fdiv(cl).round(2)
          end
      end

      def valid?
        value >= SAFE_VALUE
      end
    end

    class DebtToEquity
      SAFE_VALUE = 0.5
      attr_reader :bs

      def initialize(balance_sheet)
        @bs = balance_sheet
      end

      def value
        @value ||=
          begin
            td = bs.total_debt.first.to_f
            te = bs.total_equity.first.to_f
            te.zero? ? 0 : td.fdiv(te).round(2)
          end
      end

      def valid?
        value <= SAFE_VALUE
      end
    end

    class PriceToEarnings
      SAFE_VALUE = 15
      attr_reader :summary

      def initialize(summary)
        @summary = summary
      end

      def value
        summary.pe
      end

      def valid?
        value <= SAFE_VALUE
      end
    end

    class PriceToBookValuePerShare
      SAFE_VALUE = 1.5
      attr_reader :summary

      def initialize(summary)
        @summary = summary
      end

      def value
        price / book_value_per_share
      end

      def book_value_per_share
      end

      def valid?
        value <= SAFE_VALUE
      end
    end

    # Straight Forward Grahams Value fo a Stock
    #
    #
    class GrahamNumber
      def value
        Math.sqrt(22.5 * summary.eps * PriceToBookValuePerShare.value)
      end
    end
  end
end

