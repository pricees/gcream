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
      [ "#{symbol.upcase} Report\n================" ]
    end

    def rules
      [
        Gcream::BuffettRules::CurrentRatio.new(g_skrilla.balance_sheets.qtr).report,
        Gcream::BuffettRules::DebtToEquity.new(g_skrilla.balance_sheets.qtr).report,
        Gcream::BuffettRules::PriceToEarnings.
          new(g_skrilla.summary).report,
        Gcream::BuffettRules::BookValuePerShare.new(g_skrilla.balance_sheets.qtr).report,
        Gcream::BuffettRules::PriceToBookValuePerShare.new(g_skrilla.summary, g_skrilla.balance_sheets.qtr).report,
        Gcream::BuffettRules::GrahamsNumber.new(g_skrilla.summary, g_skrilla.balance_sheets.qtr).report,

      ]
    end

    def g_skrilla
      @g_skrilla ||= GSkrilla::build(symbol)
    end

  end
end
