describe Gcream::Rule::PriceToEarnings do
  let (:financials)  { double(summary: double(ask_price: 12.06)) }
  subject { Gcream::Rule::PriceToEarnings.new(financials.summary, 1 ) }

  it "returns the #value" do
    expect(subject.value).to eq(12.06)
  end

  it "returns valid?" do
    expect(subject).to be_valid
  end
end

