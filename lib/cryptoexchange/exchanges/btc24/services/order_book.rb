module Cryptoexchange::Exchanges
  module Btc24
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          endpoint = ticker_url(market_pair)
          output = ''
          LruTtlCache.ticker_cache.getset(endpoint) do
            begin
              response = http_get(endpoint)
              if response.code == 200
                io = StringIO.new(response.body, 'rb')
                gz = Zlib::GzipReader.new(io)
                data = gz.read
                output = JSON.parse(data)
              elsif response.code == 400
                raise Cryptoexchange::HttpBadRequestError, { response: response }
              else
                raise Cryptoexchange::HttpResponseError, { response: response }
              end
            rescue HTTP::ConnectionError => e
              raise Cryptoexchange::HttpConnectionError, { error: e, response: response }
            rescue HTTP::TimeoutError => e
              raise Cryptoexchange::HttpTimeoutError, { error: e, response: response }
            rescue JSON::ParserError => e
              raise Cryptoexchange::JsonParseError, { error: e, response: response }
            rescue TypeError => e
              raise Cryptoexchange::TypeFormatError, { error: e, response: response }
            end
          end
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Btc24::Market::API_URL}/level2/#{market_pair.base.upcase}#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          market = output.first
          order_book.base = market_pair.base
          order_book.target = market_pair.target
          order_book.market = Btc24::Market::NAME
          order_book.asks = adapt_orders(market['Asks'], market['Timestamp'])
          order_book.bids = adapt_orders(market['Bids'], market['Timestamp'])
          order_book.timestamp = Time.now.to_i
          order_book.payload = output
          order_book
        end

        def adapt_orders(orders, timestamp)
          orders.collect do |order_entry|
            price = order_entry['Price']
            amount = order_entry['Volume']
            Cryptoexchange::Models::Order.new(price: price,
                                              amount: amount,
                                              timestamp: timestamp)
          end
        end

        def http_get(endpoint)
          fetch_response = HTTP.timeout(:write => 2, :connect => 15, :read => 18)
                               .follow.get(endpoint, {
              headers: {
                  "Accept-Encoding" => "gzip"
              }
          }
          )
        end
      end
    end
  end
end
