describe Gcream::Rule::DebtToEquity do
  let (:financials) do
    data = double(total_debt: [0.14], total_equity: [1])
    double(balance_sheets: double(qtr: data))
  end

  subject { Gcream::Rule::DebtToEquity.new(qtr) }

  let(:qtr) { financials.balance_sheets.qtr }

  it "returns the #value" do
    expect(subject.value).to eq(0.14)
  end

  it "returns valid?" do
    expect(subject).to be_valid
  end
end

