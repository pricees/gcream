describe Gcream::Rule::BookValuePerShare do

  describe "#value" do
    let(:balance_sheet) do
      double(total_equity: [2], total_common_shares_outstanding: [5])
    end

    subject { Gcream::Rule::BookValuePerShare.new(balance_sheet) }

    it "returns the value" do
      expect(subject.value).to eq(0.4)
    end
  end
end
