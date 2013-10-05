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

    context "a company with postitive trend in cash" do
      let(:oa) { Gcream::CashFlowRules::CashFromOperatingActivities.new(yr) }

      it "validates" do
        expect(oa.value).to eq(4)
        expect(oa.value).to eq(4)
      end

      it "is valid" do
        expect(oa).to be_valid
      end
    end

    context "a company with postitive trend in cash" do
    end
  end

  describe "::InvestingActivities" do
    context "a company with postitive trend in cash" do
      let(:oa) { Gcream::CashFlowRules::CashFromInvestingActivities.new(yr) }

      it "is valid" do
        expect(oa).to be_valid
      end
    end
  end

  describe "::FinancingActivities" do
    context "a company with postitive trend in cash" do
      let(:oa) { Gcream::CashFlowRules::CashFromFinancingActivities.new(yr) }

      it "is valid" do
        expect(oa).to be_valid
      end
    end
  end
end
