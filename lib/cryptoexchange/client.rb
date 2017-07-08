module Cryptoexchange
  class Client
    AVAILABLE_EXCHANGES = %w(
                            bitflyer
                            coincheck
                            coinone
                            korbit
                            cryptopia
                            gatecoin
                            livecoin
                          )

    def initialize(ticker_ttl: 5 * 60)
      @cache = LruRedux::TTL::Cache.new(100, ticker_ttl)
    end

    def pairs(exchange)
      fail "#{exchange} is not a valid exchange!" unless AVAILABLE_EXCHANGES.include?(exchange)

      @cache.getset("#{exchange}_market_pairs") do
        Object.const_get("Cryptoexchange::Exchanges::#{exchange.capitalize}::Services::Pairs").new.fetch
      end
    end

    def ticker(market_pair)
      exchange = market_pair.market
      market_class = Object.const_get("Cryptoexchange::Exchanges::#{exchange.capitalize}::Services::Market")
      market = market_class.new

      if market_class.supports_individual_ticker_query?
        @cache.getset("#{exchange}_ticker_#{market_pair.base}_#{market_pair.target}") do
          market.fetch(market_pair)
        end
      else
        tickers = @cache.getset("#{exchange}_tickers") do
          market.fetch_all
        end

        tickers.find do |t|
          t.base == market_pair.base && t.target == market_pair.target
        end
      end
    end
  end
end
