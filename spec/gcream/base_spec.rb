require_relative "../../lib/gcream.rb"

describe Gcream::Base do

  let!(:g_skrilla) do
    dir = File.dirname(__FILE__) + "/.."
    GSkrilla::Base.any_instance.stub(:open).and_return(File.read("#{dir}/data/aapl.html"))
    GSkrilla::build("aapl")
  end

  let(:gcream) do
    gcream = Gcream::Base.new("aapl")
    gcream.instance_variable_set("@g_skrilla", g_skrilla)
    gcream
  end

  describe "#new" do
    it "requires an argument" do
      expect { Gcream::Base.new }.to raise_error(ArgumentError)
    end
  end

  describe "#report" do
    let(:report) { gcream.report }

    it "prints a header" do
      expect(report).to_not be_nil
    end
  end
end


