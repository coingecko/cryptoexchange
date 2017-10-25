class NumericHelper
  class << self
    def to_d(number)
      number ? BigDecimal.new(number.to_s) : nil
    end

    def divide(number, divisor)
      result = number / divisor
      result.nan? || result.infinite? ? 0 : result
    end
  end
end
