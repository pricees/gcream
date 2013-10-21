# PEG Ratio - Price/Earnings to Earnings Growth
# 
# Growth rates of 20% are not sustainable in long term (yoy)
# 
# - positive earnings for last 12 months (4 past qtrs, of growth)
# 
# -Price-to-book-value ratio less than 1.00;
# -Accelerating quarterly earnings; **
# -Positive five-year growth rate;
# -Positive pretax profit margin;
# -Relative strength rank of at least 70; ***
# -Relative strength rank of the stock in the current quarter is greater than the
# rank in the previous quarter; ***
# -O'Neil Datagraph rating of at least 70;
# -Stock selling within 15% of its maximum price during the previous two years;
# and (52 week high will do)
# -Fewer than 20 million common shares outstanding.
# 
# ** look at quarterly earning for change in trend or qoq for 
#   cyclical companies
# 
# 
# ***
# 4 quarters of price changes (delta)
# 0.40 * (price delta of current quarter)
# 0.20 * (price delta of last quarter)
# 0.20 * (price delta of 2 quarters ago)
# 0.20 * (price delta of 3 quarters ago)
# ==================
# weighted price change
# 
# rank all symbols price weight price change, look for top 30% percentile 
# 
# 
module Gcream
  module Profile
    class PEG
      include Gcream::Rule

      attr_reader :profile
      attr_writer :less_than_total_shares, :price_pct_of_52_week_hi

      def initialize(financials)
        @financials = financials
      end

      def run
        @profile = run_rules!
      end

      def valid_total_shares?
        shares = financials.balance_sheet["qtr"].
          total_common_shares_outstanding.first

        shares <= less_than_total_shares
      end

      def valid_price_rule?
        price = financials.summary.price
        yr_hi = financials.summary.year_hi

        (yr_hi - price).fdiv(yr_hi).abs <= price_pct_of_52_week_hi
      end

      def run_rules
        price_to_book_value = PriceToBookValuePerShare.new(
          financials.summary, financials.balance_sheet["qtr"], 1)

        {
          "Positive Earnings 12 Months (4 quarters)" => 
            EPS.new(financials.income_statement["qtr"], 4),
          "Price to book value < 1.0" => price_to_book_value,
          "Accelerated Quarterly Earnings" => 
            ConsecutiveAcceleratedGrowth.
              new(financials.income_statement["qtr"]),
          "Positive Earnings for 5 years (growth rate)" => 
            EPS.new(financials.income_statement["yr"], 5),
          "Positive pretax profit margin (use net profit margin)" => 
            NetProfitMargin.new(financials.income_statement["qtr"]),
          "Current price within 15% of 52 week high" =>
            price_rule,
          "Fewer than 20MM shares" => total_shares_rule
        }
      end

      def less_than_total_shares
        @less_than_total_shares ||= 20_000_000
      end

      def price_pct_of_52_week_hi
        @price_pct_of_52_week_hi ||= 0.15
      end
    end
  end
end
