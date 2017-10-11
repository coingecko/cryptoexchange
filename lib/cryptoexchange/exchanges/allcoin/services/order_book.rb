module Cryptoexchange::Exchanges
  module Allcoin
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
          "#{Cryptoexchange::Exchanges::Allcoin::Market::API_URL}/depth?symbol=#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i

          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Allcoin::Market::NAME
          order_book.asks      = output['asks']
          order_book.bids      = output['bids']
          order_book.timestamp = timestamp
          order_book.payload   = output
          order_book
        end
      end
    end
  end
end
