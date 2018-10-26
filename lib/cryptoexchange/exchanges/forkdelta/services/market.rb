module Cryptoexchange::Exchanges
  module Forkdelta
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all output
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Forkdelta::Market::API_URL}/returnTicker"
        end

        def adapt_all(output)
          # fetch token symbol list first
          symbols = Cryptoexchange::Exchanges::Forkdelta::Market.fetch_symbol
          output.map do |key, value|
            base        = symbols[value['tokenAddr']]
            target      = key.split('_').first
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Forkdelta::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Forkdelta::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['quoteVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
