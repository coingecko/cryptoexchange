module Cryptoexchange::Exchanges
  module Hanbitco
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
          "#{Cryptoexchange::Exchanges::Hanbitco::Market::API_URL}/markets/#{market_pair.base.downcase}_#{market_pair.target.downcase}/ticker"
        end

        def adapt(output, market_pair)
          output = output['data']
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Hanbitco::Market::NAME
          ticker.last = NumericHelper.to_d(output['lastPrice'])
          ticker.high = NumericHelper.to_d(output['highPrice'])
          ticker.low = NumericHelper.to_d(output['lowPrice'])
          ticker.volume = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
