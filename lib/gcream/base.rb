module Gcream
  class Base
    attr_reader :symbol

    def initialize(symbol)
      @symbol = symbol
    end

    def report
      report = [ report_header ] + rules
      puts report.map { |x| x.join("\t") }.join("\n")
      report
    end

    def report_header
      ["#{symbol.upcase} Report\n================"]
    end

    def rules
      jeah = Gcream::BuffettRules
      [
        [ "\n**Buffett / Graham Basics: \n=============="],
        jeah::PriceToEarnings.new(g_skrilla.summary).report,
        jeah::PriceToBookValuePerShare.new(g_skrilla.summary, g_skrilla.balance_sheets.qtr).report,
        jeah::GrahamsNumber.new(g_skrilla.summary, g_skrilla.balance_sheets.qtr).report,
        [ "\n\n**Buffet Rules #1: Vigilant Leadership"],
        jeah::CurrentRatio.new(g_skrilla.balance_sheets.qtr).report,
        jeah::DebtToEquity.new(g_skrilla.balance_sheets.qtr).report,
        jeah::Safety.new(g_skrilla.summary, g_skrilla.balance_sheets.qtr).report,
        [ "\n\n**Buffet Rules #2: Does this company exist in 10 years?"],
        [ "\n\n**Buffet Rules #3a: Is this stock stable?"],
        jeah::EPS.new(g_skrilla.income_statements.yr).report,
        [ "\n\n**Buffet Rules #3b: Can you write a blog about this company and what it does?"],
        jeah::BookValuePerShare.new(g_skrilla.balance_sheets.qtr).report,
        jeah::TedsEPS.new(g_skrilla.income_statements.qtr).report,

      ]
    end

    def g_skrilla
      @g_skrilla ||= GSkrilla::build(symbol)
    end

  end
end
