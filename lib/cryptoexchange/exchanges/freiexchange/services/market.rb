module Cryptoexchange::Exchanges
  module Freiexchange
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
          "#{Cryptoexchange::Exchanges::Freiexchange::Market::API_URL}/public/#{market_pair.base}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Freiexchange::Market::NAME

          ticker.volume = NumericHelper.to_d(output['public']['volume'])
          ticker.high = NumericHelper.to_d(output['public']['high'])
          ticker.low = NumericHelper.to_d(output['public']['low'])
          ticker.last = NumericHelper.to_d(output['public']['last'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end

      end
    end
  end
end
