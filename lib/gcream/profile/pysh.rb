# Edward S Price
# 2013 
#
# This "profile" is named for the strategy derived from Preston Pysh's
# wonderful series at http::/buffettsbooks.com
#
#
# Buffetts Rules
# #1 Vigilant Leadership  (2 rules)
#   Current Ratio > 1.5   Rule::CurrentRatio
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
# preston pysh,  return on equity > 7%;
# eps / equity
#
# Income Statement should have EPS rules
# ====================
# ====================
# OWNERS EARNINGS: 
# owners earnings = net income + depr. + amort. + non cash items
#   +/- deferred taxes 
#   - capital expenditures  (spent to keep running business: computers, plant, etc)
# 
# NOTE: This boils down to
# OWNERS EARNINGS: cash from operatings activities - capital expenditures
# 
# owner's earnings per share = owners earnings / number of shares (diluted)
# owners earnings per share vs (accounting) eps
# 
# accounting earnings: eps
# buffetts owners earnings:
# actually earnings:  dividend + book value
# 
# buffett: tangible assets need to be replaced/maintained
# 
# =======================
# make sure you check these summaries
# 
# compare 10 years of owners earnings
#
# My rules:
#   Look for 4 quarters of increasing growth, seasonal companies be damned!
module Gcream
  module Strategy
    class Pysh
      include Gcream::Rule

      attr_reader :profile, :financials
      attr_writer :less_than_total_shares, :price_pct_of_52_week_hi

      def initialize(financials)
        @financials = financials
      end

      def run
        @profile = run_rules!
      end

      def valid_total_shares?
        shares = financials.balance_sheets["qtr"].
          total_common_shares_outstanding.first

        shares <= less_than_total_shares
      end

      def valid_price_rule?
        price = financials.summary.price
        yr_hi = financials.summary.year_hi

        (yr_hi - price).fdiv(yr_hi).abs <= price_pct_of_52_week_hi
      end

      def run_rules!
        price_to_book_value = PriceToBookValuePerShare.new(
          financials.summary, financials.balance_sheets["qtr"], 1)

        vigilant_leadership.merge(stable_and_understandable).
          merge(intrinsic_value).
          merge(teds_rules)
      end

      # #1 Vigilant Leadership  (2 rules)
      #   Current Ratio > 1.5   Rule::CurrentRatio
      #   Debt / Equity  < 0.5
      def vigilant_leadership
        qtr_bs = financials.balance_sheets["qtr"]
        { 
          "Current Ratio" => CurrentRatio.new(qtr_bs),
          "Debt-to-Equity" => DebtToEquity.new(qtr_bs),
        }
      end
      
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
      def stable_and_understandable
        yr_is = financials.income_statements["yr"]
        yr_bs = financials.balance_sheets["yr"]
        key_ratios = financials.key_ratios

        {
          "CHECKIncreasing YoY (diluted normalized) EPS" => 
            EPS.new(yr_is),
          "Increasing YoY equity" => 
            TotalEquity.new(yr_bs),
          "Increasing Book Value Per Share Growth" =>
            BookValuePerShareGrowth.new(yr_bs, key_ratios),
          "Increasing Debt-to-Equity" => 
            DebtToEquityGrowth.new(yr_bs),
        }
      end

      def intrinsic_value
        {}
      end

      def teds_rules
        qtr_is = financials.income_statements["qtr"]
        { "Increasing QoQ (diluted normalized) EPS" => EPS.new(qtr_is), }
      end
    end
  end
end
