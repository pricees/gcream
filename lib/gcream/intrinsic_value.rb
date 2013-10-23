module Gcream
  class IntrinsicValue

    # Public: The avg book value change
    #
    # current_bv  - Current book value
    # original_bv - Original book value
    # years       - Years between book values
    #
    # NOTE: This is ripped off Pysh's formula:
    # http://www.buffettsbooks.com/intelligent-investor/stocks/intrinsic-value-calculator.html
    #
    # Returns a decimal
    def avg_bv_change(current_bv, original_bv, years)
      current_bv  = current_bv.to_f
      original_bv = original_bv.to_f
      years       = years.to_f

      upper = 1.fdiv(years)
      base  = current_bv.fdiv(original_bv)
      tmp   = base ** upper
      100 * (tmp - 1).round(4)
    end

    # Public: The avg book value change
    #
    # cash_out          - Sum of dividends paid for 1 year
    # current_bv        - Current book value
    # avg_pct_bv_change - Average change in book value 
    # years             - Years, generally 10 years (if 10 yr note)
    # discount_rate     - 10 year federal note
    #
    # NOTE: This is ripped off Pysh's formula:
    # http://www.buffettsbooks.com/intelligent-investor/stocks/intrinsic-value-calculator.html
    #
    # Returns a decimal
    def intrinsic_value(values)
      coupon            = values[0].to_f
      current_bv        = values[1].to_f # par
      avg_pct_bv_change = values[2].to_f # bvc
      years             = values[3].to_f
      discount_rate     = values[4].to_f # r

      percent = (1 + avg_pct_bv_change.fdiv(100))
      base    = percent ** years
      discount_rate = discount_rate/100;
      parr    = current_bv * base
      extra   = (1 + discount_rate) ** years

      # I have no clue what this does
      tmp =  ((coupon * (1 - 1/extra))/discount_rate) 
      tmp += parr/extra
      tmp.round(2)
    end
  end
end
