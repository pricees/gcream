describe Gcream::Rule::MarginOfSafety do

  subject { Gcream::Rule::MarginOfSafety.new(20) }
  let(:valid) { Gcream::Rule::MarginOfSafety::VALUE }

  describe "#value" do
    it "returns the margin of safety" do
      expect(subject.value).to eq(5)
    end
  end

  describe "#valid" do
    it "returns valid if gte safety margin" do
      expect(Gcream::Rule::MarginOfSafety.new(5)).to be_valid
    end

    it "returns valid if lt safety margin" do
      expect(Gcream::Rule::MarginOfSafety.new(20)).to_not be_valid
    end
  end
end
