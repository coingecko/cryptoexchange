module Cryptoexchange::Exchanges
  module Gemini
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Gemini::Market::API_URL}/book/#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Gemini::Market::NAME
          order_book.asks      = output['asks']
          order_book.bids      = output['bids']
          order_book.timestamp = output['bids'][0]['timestamp'].to_i
          order_book.payload   = output
          order_book
        end
      end
    end
  end
end
