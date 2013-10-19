describe Gcream::Rule::CurrentRatio do
  let (:financials) do
    data = double(total_current_assets: [1.88],
                  total_current_liabilities: [1])
    double(balance_sheets: double(qtr: data))
  end

  let(:qtr) { financials.balance_sheets.qtr }

  subject { Gcream::Rule::CurrentRatio.new(qtr) }

  it "returns the #value" do
   expect(subject.value).to eq(1.88)
  end

  it "returns valid?" do
   expect(subject).to be_valid
  end
end
