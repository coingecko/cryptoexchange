module Cryptoexchange::Exchanges
  module StakeCube
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::StakeCube::Market::API_URL}/exchange/tickers"
        end

        def adapt_all(output)
          output.map do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: pair['target'],
              target: pair['base'],
              market: StakeCube::Market::NAME
            )

            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = StakeCube::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.flip_volume(NumericHelper.to_d(output['volume']), ticker.last)
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
