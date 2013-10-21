describe Gcream::Profile::PEG do

  subject { Gcream::Profile::PEG.new(nil) }

  describe "#run" do
  end

  describe "#valid_total_shares?" do
    let(:financials) do
      double(balance_sheet: {
        "qtr" => double(total_common_shares_outstanding: [20e6])})
    end

    before { subject.stub(:financials).and_return(financials) }

    it "returns true is less-than-or-eq valid shares" do
      expect(subject).to be_valid_total_shares
    end

    it "returns true is less-than-or-eq valid shares" do
      subject.less_than_total_shares -= 1
      expect(subject).to_not be_valid_total_shares
    end
  end

  describe "#valid_price_rule?" do
    let(:financials) do
      double(summary: double(price: 85, year_hi: 100))
    end

    before { subject.stub(:financials).and_return(financials) }

    it "returns true is less-than-or-eq valid price pct" do
      expect(subject).to be_valid_price_rule
    end

    it "returns true is less-than-or-eq valid shares" do
      subject.price_pct_of_52_week_hi -= 1
      expect(subject).to_not be_valid_price_rule
    end
  end
end
