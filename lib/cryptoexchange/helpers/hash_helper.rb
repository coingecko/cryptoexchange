module HashHelper
  class << self
    # "Polyfill" of the Hash#dig method from Ruby 2.3
    #
    #   Examples
    #
    #     > dig({a: {b: 1}}, :a, :b)
    #     => 2
    #
    #     > dig({a: {b: 1}}, :a, :c)
    #     => nil
    def dig(obj, *args)
      if obj.nil? || args.empty?
        obj
      else
        dig(obj[args.first], *args[1..-1])
      end
    end
  end
end
