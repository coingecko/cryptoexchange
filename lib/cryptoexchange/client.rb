module Cryptoexchange
  class Client
    def initialize(ticker_ttl: 3)
      LruTtlCache.ticker_cache(ticker_ttl)
    end

    def trade_page_url(exchange, args={})
      pairs_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Market"
      pairs_class = Object.const_get(pairs_classname)
      pairs_class.trade_page_url(base: args[:base], target: args[:target])
    end

    def pairs(exchange)
      pairs_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Pairs"
      pairs_class = Object.const_get(pairs_classname)
      pairs_object = pairs_class.new
      pairs_object.fetch
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
          t.base.casecmp(market_pair.base) == 0 &&
            t.target.casecmp(market_pair.target) == 0
        end
      end

      rescue NoMethodError => e
        raise Cryptoexchange::ResultParseError, { response: "General no method error thrown" }
    end

    def available_exchanges
      folder_names = Dir[File.join(File.dirname(__dir__), 'cryptoexchange', 'exchanges', '**')]
      folder_names.map do |folder_name|
        folder_name.split('/').last
      end.sort
    end

    def exchange_for(currency)
      exchanges = []
      available_exchanges.each do |exchange|
        pairs = pairs(exchange)
        next if pairs.is_a?(Hash) && !pairs[:error].empty?
        pairs.each do |pair|
          if [pair.base, pair.target].include?(currency.upcase)
            exchanges << exchange
            break
          end
        end
      end
      exchanges.uniq.sort
    end

    def order_book(market_pair)
      exchange = market_pair.market
      market_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::OrderBook"
      market_class = Object.const_get(market_classname)
      order_book = market_class.new

      if market_class.supports_individual_ticker_query?
        order_book.fetch(market_pair)
      else
        order_books = order_book.fetch
        order_books.find do |o|
          o.base.casecmp(market_pair.base) == 0 &&
            o.target.casecmp(market_pair.target) == 0
        end
      end
    end

    def trades(market_pair)
      exchange = market_pair.market
      market_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Trades"
      market_class = Object.const_get(market_classname)
      trades = market_class.new
      trades.fetch(market_pair)
    end
  end
end
