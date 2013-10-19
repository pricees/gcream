describe Gcream::Rule::ConsecutiveGrowth do
  context "initialized growth rule" do
    let!(:values)    { [5, 4, 3, 2, 0] }
    let!(:statement) { double(eps: values) }

    subject { Gcream::Rule::ConsecutiveGrowth.new(statement, :eps, nil, "Quarters") }

    describe "#value" do
      it "returns number of consecutive increasing numbers " do
        expect(subject.value).to eq(5)
      end
    end

    describe "#valid?" do
      context "a rule value that succeeds against the values" do
        before { subject.rule_value = 3 }
        
        it "is valid" do
          expect(subject).to be_valid
        end
      end

      context "a rule value that fails against the values" do
        before { subject.rule_value = 6 }

        it "is not valid" do
          expect(subject).to_not be_valid
        end
      end
    end
  end
end
