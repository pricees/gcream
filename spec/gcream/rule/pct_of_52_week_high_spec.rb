describe Gcream::Rule::PctOf52WeekHigh do

  describe "#value" do
    let(:summary) { double(percent_change_from_52wk_high: 14) }

    subject { Gcream::Rule::PctOf52WeekHigh.new(summary.percent_change_from_52wk_high) }

    it "returns the value" do
      expect(subject.value).to eq(14)
    end

    context "shares are less than or equal to valid value" do
      it "returns the value" do
        expect(subject).to be_valid
      end
    end

    context "percent change are greater than valid value" do
      let(:summary) { double(percent_change_from_52wk_high: 16) }

      subject { Gcream::Rule::PctOf52WeekHigh.new(summary.percent_change_from_52wk_high) } 
      it "wont be valid" do
        expect(subject).to_not be_valid
      end
    end
  end
end
