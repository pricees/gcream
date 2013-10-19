describe Gcream::Rule::ConsecutiveDecline do
  context "initialized growth rule" do
    let!(:values)    { [3, 4, 5, 2, 0] }
    let!(:statement) { double(eps: values) }

    subject { Gcream::Rule::ConsecutiveDecline.new(statement, :eps, nil, "Quarters") }

    describe "#value" do
      it "returns number of consecutive increasing numbers " do
        expect(subject.value).to eq(3)
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
        subject { Gcream::Rule::ConsecutiveDecline.new(statement, :eps, 6, "Quarters") }

        it "is not valid" do
          expect(subject).to_not be_valid
        end
      end
    end
  end
end
