require_relative "../../lib/gcream.rb"

describe Gcream::IncomeStatementRules do

  let (:g_skrilla) do
    dir  = File.dirname(__FILE__) + "/.."
    data = File.read("#{dir}/data/aapl.html")
    GSkrilla::Summary.any_instance.stub(:open).and_return(
      File.read("#{dir}/data/aapl.html.summary")
    )
    GSkrilla::Base.any_instance.stub(:open).and_return(data)
    GSkrilla::build("aapl")
  end

  let(:qtr)  { g_skrilla.income_statments.qtr }
  let(:yr)  { g_skrilla.income_statments.yr }

  describe "::new" do
    it "assert true" do
      expect(true).to eq(true)
    end
  end

  describe "::EPS" do
  end

end
