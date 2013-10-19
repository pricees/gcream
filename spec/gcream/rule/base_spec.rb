describe Gcream::Rule::Base  do
  describe "#initialize" do
    it "raises error for wrong amout of arguments" do
      expect { Gcream::Rule::Base.new(1,2) }.to raise_error
    end

    it "requires 3 arguments" do
      expect { Gcream::Rule::Base.new(1,2,3) }.not_to raise_error
    end
  end
end
