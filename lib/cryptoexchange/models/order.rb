module Cryptoexchange
  module Models
    class Order
      attr_accessor :price, :amount, :timestamp

      def initialize(args={})
        @price      = args[:price]
        @amount     = args[:amount]
        @timestamp  = args[:timestamp] || nil
      end
    end
  end
end
