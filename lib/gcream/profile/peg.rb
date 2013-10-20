# PEG Ratio - Price/Earnings to Earnings Growth
# 
# Growth rates of 20% are not sustainable in long term (yoy)
# 
# positive earnings for last 12 months
# 
# -Price-to-book-value ratio less than 1.00;
# -Accelerating quarterly earnings; **
# -Positive five-year growth rate;
# -Positive pretax profit margin;
# -Relative strength rank of at least 70; ***
# -Relative strength rank of the stock in the current quarter is greater than the
# rank in the previous quarter; ***
# -O'Neil Datagraph rating of at least 70;
# -Stock selling within 15% of its maximum price during the previous two years;
# and (52 week high will do)
# -Fewer than 20 million common shares outstanding.
# 
# ** look at quarterly earning for change in trend or qoq for cyclical companiesa
# 
# 
# ***
# 4 quarters of price changes (delta)
# 0.40 * (price delta of current quarter)
# 0.20 * (price delta of last quarter)
# 0.20 * (price delta of 2 quarters ago)
# 0.20 * (price delta of 3 quarters ago)
# ==================
# weighted price change
# 
# rank all symbols price weight price change, look for top 30% percentile 
# 
# 
module Gcream
  module Profile
    class PEG
    end
  end
end
