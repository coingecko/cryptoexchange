module Cryptoexchange::Exchanges
  module DexBlue
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super ticker_url(market_pair)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::DexBlue::Market::API_URL}/market/#{market_pair.base.upcase}#{market_pair.target.upcase}/ticker"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = DexBlue::Market::NAME
          ticker.last      = NumericHelper.to_d(output['data']['rate'])
          ticker.volume    = NumericHelper.to_d(output['data']['volumeTraded24h'])
          ticker.high      = NumericHelper.to_d(output['data']['high24h'])
          ticker.low       = NumericHelper.to_d(output['data']['low24h'])
          ticker.change    = NumericHelper.to_d(output['data']['change24h'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
