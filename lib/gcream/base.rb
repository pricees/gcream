module Gcream
  class Base

    attr_reader :symbol, :adapter

    def initialize(symbol, adapter)
      @symbol = symbol
      @adapter = adapter
    end

    def rules
      jeah = Gcream::BuffettRules
      [
        [ "\n**Buffett / Graham Basics: \n=============="],
        jeah::PriceToEarnings.new(financials.summary).report,
        jeah::PriceToBookValuePerShare.new(financials.summary, financials.balance_sheets.qtr).report,
        jeah::GrahamsNumber.new(financials.summary, financials.balance_sheets.qtr).report,
        [ "\n\n**Buffet Rules #1: Vigilant Leadership"],
        jeah::CurrentRatio.new(financials.balance_sheets.qtr).report,
        jeah::DebtToEquity.new(financials.balance_sheets.qtr).report,
        jeah::Safety.new(financials.summary, financials.balance_sheets.qtr).report,
        [ "\n\n**Buffet Rules #2: Does this company exist in 10 years?"],
        [ "\n\n**Buffet Rules #3a: Is this stock stable?"],
        jeah::EPS.new(financials.income_statements.yr).report,
        [ "\n\n**Buffet Rules #3b: Can you write a blog about this company and what it does?"],
        jeah::BookValuePerShare.new(financials.balance_sheets.qtr).report,
        jeah::TedsEPS.new(financials.income_statements.qtr).report,
      ]
    end

    def financials
      @financials ||= adapter::build(symbol)
    end
  end
end
