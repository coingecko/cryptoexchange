module Cryptoexchange::Exchanges
  module Boa
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
          "#{Cryptoexchange::Exchanges::Boa::Market::API_URL}"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair['label'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Boa::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Boa::Market::NAME
          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.high      = NumericHelper.to_d(output['high_price'])
          ticker.low       = NumericHelper.to_d(output['low_price'])
          ticker.volume    = NumericHelper.to_d(output['volume_traded'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
