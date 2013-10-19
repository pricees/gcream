
require_relative "../../spec_helper.rb"

describe Gcream::Rule::BookValuePerShare do
  let (:financials) do
    data = double(total_current_assets: [1.88],
                  total_current_liabilities: [1])
    double(balance_sheets: double(qtr: data))
  end

  it "returns the #value" do
    puts "Write a Test"
  end
end
