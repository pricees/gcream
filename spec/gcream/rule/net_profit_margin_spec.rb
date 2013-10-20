describe Gcream::Rule::NetProfitMargin do

  let(:statement)  { double(net_income: 2, revenue: 4) }
  subject { Gcream::Rule::NetProfitMargin.new(statement) }

  describe "#value" do
    it "returns the value" do
      expect(subject.value).to eq(0.5)
    end
  end

end
