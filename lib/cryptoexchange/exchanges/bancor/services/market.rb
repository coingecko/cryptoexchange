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
          "#{Cryptoexchange::Exchanges::Bancor::Market::API_URL}/currencies/#{market_pair.base}/ticker?fromCurrencyCode=#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bancor::Market::NAME
          ticker.last      = NumericHelper.to_d(output['data']['price'])
          ticker.high      = NumericHelper.to_d(output['data']['price24hLow'])
          ticker.low       = NumericHelper.to_d(output['data']['price24hLow'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['data']['volume24h'].to_f / 10 ** 18), ticker.last)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
