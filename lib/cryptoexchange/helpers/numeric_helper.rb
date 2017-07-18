class NumericHelper
  class << self
    def to_d(number)
      number ? BigDecimal.new(number.to_s) : nil
    end
  end
end
