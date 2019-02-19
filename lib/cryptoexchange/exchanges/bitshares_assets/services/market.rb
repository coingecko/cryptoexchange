module Cryptoexchange::Exchanges
  module BitsharesAssets
    module Services
      class Market < Cryptoexchange::Services::Market
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
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::BitsharesAssets::Market::API_URL}/asset/markets?asset=#{target}"
        end

        def adapt(output, market_pair)
          output = output[market_pair.base]
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BitsharesAssets::Market::NAME

          ticker.last      = NumericHelper.divide(1.0, NumericHelper.to_d(output['price']))
          ticker.volume    = NumericHelper.to_d(output['volume24'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
