require_relative "../../lib/gcream.rb"

describe Gcream::Base do

  let (:symbol) { "XXX" }
  let (:adapter) { double(build: :financials) }

  subject { Gcream::Base.new symbol, adapter }

  describe "#new" do
    it "requires arguments" do
      expect { Gcream::Base.new }.to raise_error(ArgumentError)
    end
  end

  describe "#financials" do
    it "returns non fill" do
      expect(subject.financials).to_not be_nil
    end
  end

  describe "#rules" do
    it "has them" do
      expect(subject.rules).to_not be_nil
    end
  end
end
