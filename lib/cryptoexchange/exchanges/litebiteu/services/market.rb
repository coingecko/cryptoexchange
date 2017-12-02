module Cryptoexchange::Exchanges
  module Litebiteu
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Litebiteu::Market::API_URL}/markets"
        end

        def adapt_all(output)
          fetch_timestamp = DateTime.now.to_time.to_i

          output['result'].map do |base, market|
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: 'EUR',
                            market: Bithumb::Market::NAME
                          )
            adapt(market, market_pair, fetch_timestamp)
          end
        end

        def adapt(market, market_pair, fetch_timestamp)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Litebiteu::Market::NAME
          ticker.ask       = NumericHelper.to_d(market['buy'])
          ticker.bid       = NumericHelper.to_d(market['sell'])
          ticker.volume    = NumericHelper.to_d(market['volume'])
          ticker.last      = (ticker.ask + ticker.bid) / 2
          ticker.timestamp = fetch_timestamp
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
