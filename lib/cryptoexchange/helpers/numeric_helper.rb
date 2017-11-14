class NumericHelper
  class << self
    def to_d(number)
      if number
        number.empty? ? nil : BigDecimal.new(number.to_s)
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
