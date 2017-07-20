module Cryptoexchange
  class Client
    class << self
      def available_exchanges
        Dir.entries("./lib/cryptoexchange/exchanges")[2..-1].sort.freeze
      end
    end

    def initialize(ticker_ttl: 3)
      LruTtlCache.ticker_cache(ticker_ttl)
    end

    def pairs(exchange)
      pairs_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Pairs"
      Object.const_get(pairs_classname).new.fetch
    end

    def ticker(market_pair)
      exchange = market_pair.market
      market_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Market"
      market_class = Object.const_get(market_classname)
      market = market_class.new

      if market_class.supports_individual_ticker_query?
        market.fetch(market_pair)
      else
        tickers = market.fetch
        tickers.find do |t|
          t.base == market_pair.base && t.target == market_pair.target
        end
      end
    end
  end
end
