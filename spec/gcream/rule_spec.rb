require_relative "../../lib/gcream/rule.rb"
require_relative "../../lib/array_ext.rb"

describe Gcream::Rule do
  describe "#initialize" do
    it "raises error for wrong amout of arguments" do
      expect { Gcream::Rule.new(1,2) }.to raise_error
    end

    it "requires 3 arguments" do
      expect { Gcream::Rule.new(1,2,3) }.not_to raise_error
    end
  end
end

describe Gcream::ConsecutiveGrowthRule do
  context "initialized growth rule" do
    let!(:values)    { [5, 4, 3, 2, 0] }
    let!(:statement) { double(eps: values) }

    subject { Gcream::ConsecutiveGrowthRule.new(statement, :eps, nil, "Quarters") }

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

describe Gcream::ConsecutiveDeclineRule do
  context "initialized growth rule" do
    let!(:values)    { [3, 4, 5, 2, 0] }
    let!(:statement) { double(eps: values) }

    subject { Gcream::ConsecutiveDeclineRule.new(statement, :eps, nil, "Quarters") }

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
        subject { Gcream::ConsecutiveDeclineRule.new(statement, :eps, 6, "Quarters") }

        it "is not valid" do
          expect(subject).to_not be_valid
        end
      end
    end
  end
end
