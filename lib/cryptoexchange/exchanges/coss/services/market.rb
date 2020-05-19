module Cryptoexchange::Exchanges
  module Coss
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
          "#{Cryptoexchange::Exchanges::Coss::Market::API_URL}/ticker"
        end

        def adapt_all(result)
          result.map do |market_name, value|
            base, target = market_name.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Coss::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          # Other fields on output that are not used: start24h, change24h
          # No values assigned to ticker fields: ask, bid

          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coss::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.volume    = NumericHelper.to_d(output['base_volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
