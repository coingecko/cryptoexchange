module Cryptoexchange::Exchanges
  module Bitonbay
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
          "#{Cryptoexchange::Exchanges::Bitonbay::Market::API_URL}/api-public-ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base: pair['zone_type'],
              target: pair['currency_type'],
              market: Bitonbay::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitonbay::Market::NAME
          ticker.last      = NumericHelper.to_d(output['24h_price'].to_f)
          ticker.volume    = NumericHelper.to_d(output['24h_amount'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
