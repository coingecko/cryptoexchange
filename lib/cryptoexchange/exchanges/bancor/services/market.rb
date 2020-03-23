module Cryptoexchange::Exchanges
  module Bancor
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
          "#{Cryptoexchange::Exchanges::Bancor::Market::API_URL}/currencies/#{market_pair.base}/ticker?fromCurrencyCode=#{market_pair.target}&displayCurrencyCode=#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output = output["data"]
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bancor::Market::NAME
          ticker.last      = NumericHelper.divide(1, NumericHelper.to_d(output['price']))
          ticker.volume    = NumericHelper.flip_volume(NumericHelper.to_d(output['volume24hD']), NumericHelper.to_d(output['price']))
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
