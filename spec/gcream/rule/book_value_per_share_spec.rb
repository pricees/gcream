require "spec_helper"

describe Gcream::Rule::BookValuePerShare do

  describe "#value" do
    let(:balance_sheet) { double(total_equity: [2]) }

    let(:summary) { double(float_shares: 5) }

    subject { Gcream::Rule::BookValuePerShare.new(balance_sheet, summary) }

    it "returns the value" do
      expect(subject.value).to eq(0.4)
    end
  end
end
