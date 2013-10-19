require_relative "../../lib/gcream.rb"

describe Gcream::BuffettRules do

  describe "::CurrentRatio" do
    let (:financials) do
      data = double(total_current_assets: [1.88],
                    total_current_liabilities: [1])
      double(balance_sheets: double(qtr: data))
    end

    let(:qtr) { financials.balance_sheets.qtr }

    it "returns the #value" do
     res = Gcream::BuffettRules::CurrentRatio.new(qtr)
     expect(res.value).to eq(1.88)
    end

    it "returns valid?" do
     res = Gcream::BuffettRules::CurrentRatio.new(qtr)
     expect(res.valid?).to be_true
    end
  end

  describe "::DebtToEquity" do
    let (:financials) do
      data = double(total_debt: [0.14], total_equity: [1])
      double(balance_sheets: double(qtr: data))
    end

    let(:qtr) { financials.balance_sheets.qtr }

    it "returns the #value" do
     res = Gcream::BuffettRules::DebtToEquity.new(qtr)
     expect(res.value).to eq(0.14)
    end

    it "returns valid?" do
     res = Gcream::BuffettRules::DebtToEquity.new(qtr)
     expect(res.valid?).to be_true
    end
  end

  describe "::PriceToEarnings" do
    let (:financials)  { double(summary: double(pe: 12.06)) }

    it "returns the #value" do
     res = Gcream::BuffettRules::PriceToEarnings.new(financials.summary)
     expect(res.value).to eq(12.06)
    end

    it "returns valid?" do
     res = Gcream::BuffettRules::PriceToEarnings.new(financials.summary)
     expect(res.valid?).to be_true
    end
  end

end
