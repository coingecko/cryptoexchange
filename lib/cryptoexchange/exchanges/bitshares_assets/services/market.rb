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
          output = super(ticker_url)
          adapt(output, market_pair)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::BitsharesAssets::Market::API_URL}/asset/markets?asset=BTS"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BitsharesAssets::Market::NAME

          ticker.last      = NumericHelper.to_d(output['OPEN.BTC']['price'])
          ticker.volume    = NumericHelper.to_d(output['OPEN.BTC']['volume24'])
          ticker.timestamp = Time.parse(output['OPEN.BTC']['updated']).to_i
          ticker.payload   = output['OPEN.BTC']
          ticker
        end
      end
    end
  end
end
