describe Gcream::IntrinsicValue do

  describe "#average_book_value" do
    it "gets the average book value" do
      [[1, 1, 1, 0],
      [10, 1, 10, 25.89]].each do |cbv, obv, yrs, avg|
        expect(subject.avg_bv_change(cbv, obv, yrs)).to eq(avg)
      end
    end
  end

  describe "#intrinsic_value" do
    it "gets the value" do
      [[1, 1, 1, 1, 1, 1.990],
      [2, 3, 4, 10, 5, 18.17], ].each do |values|
        value = values.pop
        expect(subject.intrinsic_value(values)).to eq(value)
      end
    end
  end
end
