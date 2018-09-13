module Cryptoexchange::Exchanges
  module Coinchangex
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
          "#{Cryptoexchange::Exchanges::Coinchangex::Market::API_URL}/returnTicker"
        end

        def adapt_all(output)
          # fetch token symbol list first
          symbols = Cryptoexchange::Exchanges::Coinchangex::Market.fetch_symbol
          output.map do |key, value|
            base        = symbols[value['tokenAddr']]
            target      = key.split('_').first
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinchangex::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinchangex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'].to_f)
          ticker.bid       = NumericHelper.to_d(output['bid'].to_f)
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.volume    = NumericHelper.to_d(output['quoteVolume'].to_f)
          ticker.timestamp = Time.parse(output['updated']).to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
