require "spec_helper"

describe Gcream::Rule::EPS do

  let(:income_statement) do
    double(diluted_normalized_eps: double(consecutive_growth: 5))
  end

  subject { Gcream::Rule::EPS.new(income_statement) }

  describe "#value" do
    it "returns the consecutive growth " do
      expect(subject.value).to eq(5)
    end
  end

  describe "#valid?" do
    let(:value) { Gcream::Rule::EPS::VALUE }
    it "is valid when consecutive grown is >= VALUE" do
      expect(subject).to be_valid
    end

    context " when consecutive grown is < VALUE" do
     let(:income_statement) do
       double(diluted_normalized_eps: double(consecutive_growth: 4))
     end
     subject { Gcream::Rule::EPS.new(income_statement) }

     it "is not valid" do
       expect(subject).to_not be_valid
     end
    end
  end
end
