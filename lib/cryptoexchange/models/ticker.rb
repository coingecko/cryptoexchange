module Cryptoexchange
  module Models
    class Ticker
      attr_accessor :base, :target, :market, :last,
                    :bid, :ask, :high, :low, :avg,
                    :volume, :timestamp
    end
  end
end
