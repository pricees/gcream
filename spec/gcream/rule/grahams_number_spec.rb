describe Gcream::Rule::GrahamsNumber do

  let(:summary) { double(eps: 5, price: 15) }
  let(:pbv) { 22.5 }

  subject { Gcream::Rule::GrahamsNumber.new(pbv, summary) }

  describe "#value" do
    it "returns the consecutive growth " do
      expect(subject.value).to eq(50.31)
    end
  end

  describe "#valid?" do
    context "when Grahams number is greater than price" do
      let(:summary) { double(eps: 5, price: 52) }

      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "when Grahams number is greater than price" do
      let(:summary) { double(eps: 5, price: 50) }

      it "is valid" do
        expect(subject).to_not be_valid
      end
    end
  end
end
