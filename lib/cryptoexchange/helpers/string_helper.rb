class StringHelper
  class << self
    def camelize(str)
      str.split('_').map {|w| w.capitalize}.join
    end
  end
end
