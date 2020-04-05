module Cryptoexchange
  class Client
    def initialize
    end

    def cache
      Cryptoexchange::Cache.ticker_cache
    end

    def trade_page_url(exchange, args={})
      pairs_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Market"
      pairs_class = Object.const_get(pairs_classname)
      pairs_class.trade_page_url(base: args[:base], target: args[:target], inst_id: args[:inst_id])
    end

    def pairs(exchange)
      pairs_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Pairs"
      pairs_class = Object.const_get(pairs_classname)
      pairs_object = pairs_class.new
      pairs_object.fetch
    rescue HttpResponseError, HttpConnectionError, HttpTimeoutError, HttpBadRequestError, JsonParseError, JSON::ParserError, TypeFormatError, CredentialsMissingError, OpenSSL::SSL::SSLError, HTTP::Redirector::EndlessRedirectError => e
      # temporary or permanent failure, omit
      return {error: [e]}
    end

    def options_instruments(exchange)
      pairs_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Options::Instruments"
      pairs_class = Object.const_get(pairs_classname)
      pairs_object = pairs_class.new
      pairs_object.fetch
    rescue HttpResponseError, HttpConnectionError, HttpTimeoutError, HttpBadRequestError, JsonParseError, JSON::ParserError, TypeFormatError, CredentialsMissingError, OpenSSL::SSL::SSLError, HTTP::Redirector::EndlessRedirectError => e
      # temporary or permanent failure, omit
      return {error: [e]}
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
          if t.inst_id.nil? || t.inst_id == ""
            (t.base.casecmp(market_pair.base) == 0 && t.target.casecmp(market_pair.target) == 0)
          else
            (t.inst_id.casecmp(market_pair.inst_id) == 0 )
          end
        end
      end
    end

    def options_ticker(market_pair)
      exchange = market_pair.market
      market_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Options::Ticker"
      market_class = Object.const_get(market_classname)
      market = market_class.new
      market.fetch(market_pair)
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
        pairs.compact.each do |pair|
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

    # contract_stats
    def contract_stat(market_pair)
      exchange = market_pair.market
      market_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::ContractStat"
      market_class = Object.const_get(market_classname)
      contract_stat = market_class.new

      if market_class.supports_individual_ticker_query?
        contract_stat.fetch(market_pair)
      else
        contract_stats = contract_stat.fetch
        contract_stats.find do |o|
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

    def ticker_stream(market_pair:, onopen: nil, onmessage:, onclose: nil)
      fetch_stream(
        market_pair: market_pair,
        onopen: onopen,
        onmessage: onmessage,
        onclose: onclose,
        stream_type: 'market'
      )
    end

    def trade_stream(market_pair:, onopen: nil, onmessage:, onclose: nil)
      fetch_stream(
        market_pair: market_pair,
        onopen: onopen,
        onmessage: onmessage,
        onclose: onclose,
        stream_type: 'trade'
      )
    end

    def order_book_stream(market_pair:, onopen: nil, onmessage:, onclose: nil)
      fetch_stream(
        market_pair: market_pair,
        onopen: onopen,
        onmessage: onmessage,
        onclose: onclose,
        stream_type: 'order_book'
      )
    end

    def pair_url(market_pair)
      exchange = market_pair.market
      pairs_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Pairs"
      pairs_class = Object.const_get(pairs_classname)
      pair_url = pairs_class::PAIRS_URL
    end

    def market_url(market_pair)
      exchange = market_pair.market
      market_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Market"
      market_class = Object.const_get(market_classname)

      if market_class.supports_individual_ticker_query?
        market_url = market_class.new.ticker_url(market_pair)
      else
        market_url = market_class.new.ticker_url
      end
    end

    def order_book_url(market_pair)
      exchange = market_pair.market
      order_book_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::OrderBook"
      order_book_class = Object.const_get(order_book_classname)

      if order_book_class.supports_individual_ticker_query?
        order_book_url = order_book_class.new.ticker_url(market_pair)
      else
        order_book_url = order_book_class.new.ticker_url
      end
    end

    def trades_url(market_pair)
      exchange = market_pair.market
      trades_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::Trades"
      trades_class = Object.const_get(trades_classname)
      trades_url = trades_class.new.ticker_url(market_pair)
    end

    private

    # NOTE: # https://ruby-doc.org/core-2.5.0/Thread.html#method-c-abort_on_exception
    # When set to true, if any thread is aborted by an exception, the raised exception will be re-raised in the main thread.
    def fetch_stream(market_pair:, onopen: nil, onmessage:, onclose: nil, stream_type:)
      fail 'stream_type must be one of "market", "trade", "order_book"' unless %w(market trade order_book).include?(stream_type)

      exchange         = market_pair.market
      stream_classname = "Cryptoexchange::Exchanges::#{StringHelper.camelize(exchange)}::Services::#{StringHelper.camelize(stream_type)}Stream"
      stream_class     = Object.const_get(stream_classname)
      stream           = stream_class.new

      Thread.new do
        EM.run do
          ws = WebSocket::EventMachine::Client.connect(uri: stream.url)

          ws.onopen do
            onopen.call if onopen
            ws.send(stream.subscribe_event(market_pair))
          end

          ws.onmessage do |message, _|
            message = JSON.parse(message)

            if stream.valid_message?(message)
              onmessage.call(stream.parse_message(message, market_pair))
            end
          end

          ws.onclose do
            onclose.call if onclose
          end
        end
      end
    end
  end
end
