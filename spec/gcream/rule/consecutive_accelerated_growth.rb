describe Gcream::Rule::ConsecutiveAcceleratedGrowth do

  let(:income_statement) { double(earnings: [15, 10, 8, 4, 1]) }

  describe "#growth_percentages" do

    subject do
      Gcream::Rule::ConsecutiveAcceleratedGrowth.new(income_statement) 
    end

    it "has growth percentages" do
      expect(subject.growth_percentages).to eq([0.5, 0.25, 1, 3 ])
    end

    it "has a value of 2" do
      expect(subject.value).to eq(2)
    end
  end
end
