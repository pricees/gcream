describe Gcream::Rule::FloatShares do

  describe "#value" do
    let(:summary) { double(float_shares: 20_000_000) }

    subject { Gcream::Rule::FloatShares.new(summary.float_shares) }

    it "returns the value" do
      expect(subject.value).to eq(20_000_000)
    end

    context "shares are less than or equal to valid value" do
      it "returns the value" do
        expect(subject).to be_valid
      end
    end

    context "shares are greater than valid value" do
      let(:summary) { double(float_shares: 19_000_000) }

      subject { Gcream::Rule::FloatShares.new(summary.float_shares) }

      it "wont be valid" do
        expect(subject).to_not be_valid
      end
    end
  end
end
