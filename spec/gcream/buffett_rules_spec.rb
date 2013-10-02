require_relative "../../lib/gcream.rb"

describe Gcream::BuffettRules do

  let (:g_skrilla) do
    dir  = File.dirname(__FILE__) + "/.."
    data = File.read("#{dir}/data/aapl.html")
    GSkrilla::Summary.any_instance.stub(:open).and_return(
      File.read("#{dir}/data/aapl.html.summary")
    )
    GSkrilla::Base.any_instance.stub(:open).and_return(data)
    GSkrilla::build("aapl")
  end

  it "loads g_skrilla" do
    #p g_skrilla
  end

  describe "::CurrentRatio" do
    let(:qtr) { g_skrilla.balance_sheets.qtr }

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
    let(:qtr) { g_skrilla.balance_sheets.qtr }

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
    let(:summary) { g_skrilla.summary }


    it "returns the #value" do
     res = Gcream::BuffettRules::PriceToEarnings.new(summary)
     expect(res.value).to eq(12.06)
    end

    it "returns valid?" do
     res = Gcream::BuffettRules::PriceToEarnings.new(summary)
     expect(res.valid?).to be_true
    end
  end

end
