require_relative "../../lib/gcream.rb"

describe Gcream::CashFlowRules do

  let (:g_skrilla) do
    dir  = File.dirname(__FILE__) + "/.."
    data = File.read("#{dir}/data/aapl.html")
    GSkrilla::Summary.any_instance.stub(:open).and_return(
      File.read("#{dir}/data/aapl.html.summary")
    )
    GSkrilla::Base.any_instance.stub(:open).and_return(data)
    GSkrilla::build("aapl")
  end

  let(:qtr) { g_skrilla.cash_flows.qtr }
  let(:yr)  { g_skrilla.cash_flows.yr }

  describe "::new" do

    it "returns six reports" do
      klass = Gcream::CashFlowRules
      klass::CashFromOperatingActivities.stub_chain(:new, :report)
      klass::CashFromInvestingActivities.stub_chain(:new, :report)
      klass::CashFromFinancingActivities.stub_chain(:new, :report)

      res = Gcream::CashFlowRules.new(g_skrilla.cash_flows)
      expect(res.length).to eq(6)
    end
  end
  describe "::OperatingActivities" do
    context "has qtr cash_flow statement" do
      it "responds to cash from operating activities" do
        expect(qtr.cash_from_operating_activities).to be_any
      end
    end

    context "has yr cash_flow statement" do
      it "responds to cash from operating activities" do
        expect(yr.cash_from_operating_activities).to be_any
      end
    end

    context "a company with increasing operating cash" do
      let(:operating) do
        yr.stub(:cash_from_operating_activities).and_return([5,4,3,2,10])
        Gcream::CashFlowRules::CashFromOperatingActivities.new(yr)
      end

      it "is valid" do
        expect(operating).to be_valid
      end
    end

    context "a company with decreasing cash" do
      let(:operating) do
        yr.stub(:cash_from_operating_activities).and_return([4,3,2,10,1])
        Gcream::CashFlowRules::CashFromOperatingActivities.new(yr)
      end

      it "is valid" do
        expect(operating).to_not be_valid
      end
    end
  end

  describe "::InvestingActivities" do
    context "a company making increasing number of investments" do
      let(:investing) do
        yr.stub(:cash_from_investing_activities).and_return([5,6,7.8,10])
        Gcream::CashFlowRules::CashFromInvestingActivities.new(yr)
      end

      it "is valid" do
        expect(investing).to be_valid
      end
    end

    context "a company selling an increasing number of investments" do
      let(:investing) do
        yr.stub(:cash_from_investing_activities).and_return([10, 7,9, 68,10])
        Gcream::CashFlowRules::CashFromInvestingActivities.new(yr)
      end

      it "is valid" do
        expect(investing).to_not be_valid
      end
    end
  end

  describe "::FinancingActivities" do
    context "a company paying off increasing amounts of debt" do
      let(:financing) do 
        yr.stub(:cash_from_financing_activities).and_return([5,6,7.8,10])
        Gcream::CashFlowRules::CashFromFinancingActivities.new(yr)
      end

      it "is valid" do
        expect(financing).to be_valid
      end
    end

    context "a company selling increasing amounts of debt" do
      let(:financing) do 
        yr.stub(:cash_from_financing_activities).and_return([4.3,3.2,2,1])
        Gcream::CashFlowRules::CashFromFinancingActivities.new(yr)
      end

      it "is valid" do
        expect(financing).to_not be_valid
      end
    end
  end
end
