class NumericHelper
  class << self
    def to_d(number)
      if number
        num = number.to_s
        num.empty? ? nil : BigDecimal.new(num)
      else
        nil
      end
    end

    def divide(number, divisor)
      result = number / divisor
      result.nan? || result.infinite? ? 0 : result
    end
  end
end
