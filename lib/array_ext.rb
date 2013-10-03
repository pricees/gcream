module ArrayExt
  def consecutive_growth
    max   = 100_000_000_000
    count = 0
    each_with_index do |val, i|
      break if max < val 

      count = i + 1
      max   = val
    end
    count
  end

  def growth?
    self[0] > self[-1]
  end

  def decline?
    self[-1] > self[0]
  end

  def consecutive_decline
    min   = -100_000_000_000
    count = 0
    each_with_index do |val, i|
      break if min > val 

      count = i + 1
      min   = val
    end
  end
end

Array.send :include, ArrayExt
