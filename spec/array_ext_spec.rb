require_relative "../lib/array_ext.rb"

describe Array do
  describe "#growth?" do
    context "an array is first element is greater than its last" do
      let(:array) { [5, 40, 30, 32322, 4] }

      it "has growth" do
        expect(array).to be_growth
      end
    end

    context "an array is last element is greater than its first" do
      let(:array) { [4, 40, 30, 32322, 5] }

      it "doesn't have growth" do
        expect(array).to_not be_growth
      end
    end
  end

  describe "#consecutive_growth" do
    context "an array of 4 descending numbers" do
      let(:array) { [50, 40, 30, 2, 10] }

      it "has a consecutive growth of 4" do
        expect(array.consecutive_growth).to eq(4)
      end
    end

    context "an array of 2 ascending numbers" do
      let(:array) { [5, 40, ] }

      it "has a consecutive growth of 1" do
        expect(array.consecutive_growth).to eq(1)
      end
    end
  end

  describe "#decline?" do
    context "an array is first element is greater than its last" do
      let(:array) { [5, 40, 30, 32322, 4] }

      it "hasn't decline" do
        expect(array).to_not be_decline
      end
    end

    context "an array is last element is greater than its first" do
      let(:array) { [4, 40, 30, 32322, 5] }

      it "has declined" do
        expect(array).to be_decline
      end
    end
  end

  describe "#consecutive_decline" do
    context "an array of 4 descending numbers" do
      let(:array) { [50, 40, 30, 2, 10] }

      it "has a consecutive decline of 1" do
        expect(array.consecutive_decline).to eq(1)
      end
    end

    context "an array of 2 ascending numbers" do
      let(:array) { [5, 40, ] }

      it "has a consecutive decline of 2" do
        expect(array.consecutive_decline).to eq(2)
      end
    end
  end

end
