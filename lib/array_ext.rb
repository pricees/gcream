# Assume valus are ordered in descending order
module ArrayExt
  def growth?
    self[0] > self[-1]
  end

  def consecutive_growth
    max   = 100_000_000_000
    count = 0
    each_with_index do |val, i|
      break if val.nil? || max < val 

      count = i + 1
      max   = val
    end
    count
  end

  def decline?
    !growth?
  end

  def consecutive_decline
    min   = -100_000_000_000
    count = 0
    each_with_index do |val, i|
      break if val.nil? || min > val 

      count = i + 1
      min   = val
    end
    count
  end
end

Array.send :include, ArrayExt
